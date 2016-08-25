import Zewo

public struct ThreadedFileResponder: Responder {
    let path: String
    let headers : Headers
    public init(path: String, headers: Headers = [:]) {
        self.path = path
        self.headers = headers
    }

    public func respond(to request: Request) throws -> Response {
        if request.method != .get {
            return Response(status: .methodNotAllowed)
        }

        guard let requestPath = request.path else {
            return Response(status: .internalServerError)
        }

        var path = requestPath

        if path.ends(with: "/") {
            path += "index.html"
        }

        do {
            let file = try PosixFile(path: self.path + path)
            let stream = ThreadedFileStream(file: file)

            var response = Response(body: stream)

            if let
                fileExtension = file.fileExtension,
                mediaType = mediaType(forFileExtension: fileExtension) {
                response.contentType = mediaType
            }

            return response
        } catch {
            return Response(status: .notFound)
        }
    }
}

final class Box<T> {
    let value: T
    init(_ value: T) {
        self.value = value
    }
}

final class Context {
    var done = false
    let routine: () -> UnsafeMutablePointer<Void>?
    init<T>(routine: () -> T) {
        self.routine = {
            let result = routine()
            let box = Box(result)
            return UnsafeMutablePointer(OpaquePointer(bitPattern: Unmanaged.passRetained(box)))
        }
    }
}

public final class Thread<T> {

    let pthread: pthread_t
    let context: Context
    var done: Bool { return context.done }

    public init(routine: () -> (T)) {

        let context = Context(routine: routine)

        let pthreadPointer = UnsafeMutablePointer<pthread_t?>(allocatingCapacity: 1)
        defer { pthreadPointer.deallocateCapacity(1) }

        let result = pthread_create(
            pthreadPointer,
            nil, // default attributes
            { context in
                let unmanaged = Unmanaged<Context>.fromOpaque(OpaquePointer(context))
                defer { unmanaged.release() }

                let context = unmanaged.takeUnretainedValue()
                let result = context.routine()
                context.done = true
                return result
            },
            UnsafeMutablePointer(OpaquePointer(bitPattern: Unmanaged.passRetained(context)))
        )

        guard result == 0 else {
            fatalError("failed with error number \(result)")
        }

        self.pthread = pthreadPointer.pointee!
        self.context = context
    }

    public func join() -> T {
        var result: UnsafeMutablePointer<Void>?
        pthread_join(pthread, &result)

        guard result != nil else {
            fatalError("join did not return a result")
        }

        let unmanaged = Unmanaged<Box<T>>.fromOpaque(OpaquePointer(result!))
        defer { unmanaged.release() }
        let box = unmanaged.takeUnretainedValue()
        return box.value
    }

    func exit(with result: UnsafeMutablePointer<Void>? = nil) {
        pthread_exit(result)
    }

    deinit {
        pthread_detach(pthread)
    }
}

public enum FileError: ErrorProtocol {
    case failedToSendCompletely(remaining: Data)
    case failedToReceiveCompletely(received: Data)
}

public final class PosixFile: Stream {
    let file: UnsafeMutablePointer<FILE>
    let path: String
    public var closed = false

    /// assumes read
    public init(path: String) throws {
        self.path = path
        guard let file = fopen(path, "r") else {
            throw SystemError.lastOperationError!
        }
        self.file = file
    }

    lazy var fileExtension: String? = {
        guard let fileExtension = self.path.split(separator: ".").last else {
            return nil
        }

        if fileExtension.split(separator: "/").count > 1 {
            return nil
        }

        return fileExtension
    }()

    public func send(_ data: Data, timingOut deadline: Double) throws {
        fatalError("send not implemented")
    }
    public func flush(timingOut deadline: Double) throws {
        fatalError("flush not implemented")
    }

    public func receive(upTo byteCount: Int, timingOut deadline: Double = .never) throws -> Data {
        guard !closed else { throw StreamError.closedStream(data: []) }

        let buffer = UnsafeMutablePointer<Byte>(allocatingCapacity: byteCount)
        defer { buffer.deallocateCapacity(byteCount) }

        let received = fread(buffer, sizeof(Byte.self), byteCount, file)

        guard ferror(file) == 0 else {
            throw FileError.failedToReceiveCompletely(received: [])
        }

        let receivedData = Data(UnsafeBufferPointer(start: buffer, count: received))

        return receivedData
    }

    public func close() throws {
        guard !closed else {
            return
        }
        guard fclose(file) == 0 else {
            throw SystemError.lastOperationError!
        }
    }
}

final class ThreadedFileStream: Stream {
    let file: PosixFile
    init(file: PosixFile) {
        self.file = file
    }

    var closed: Bool { return file.closed }
    func close() throws {
        try file.close()
    }

    func send(_ data: Data, timingOut deadline: Double) throws {
        try file.send(data, timingOut: deadline)
    }
    func flush(timingOut deadline: Double) throws {
        try file.flush(timingOut: deadline)
    }

    func receive(upTo byteCount: Int, timingOut deadline: Double) throws -> Data {
        let thread = Thread<Data> {
            let data = try! self.file.receive(upTo: byteCount)
            return data
        }
        while !thread.done {
            nap(for: 10.milliseconds)
        }
        return thread.join()
    }
}
