
import JSON

#if os(Linux)
import Glibc
#else
import Darwin
#endif

struct JSONCreator {
    func generateJSON() -> [String: Any] {

        var finalJSON = [String: Any]()

        for i in 1...10 {
            let randomNumber = Int(arc4random_uniform(UInt32(1000)))
            finalJSON["Test Number \(i)"] = randomNumber
        }

        return finalJSON
    }
}

extension JSON {
    public static func parse(_ value: Any) -> JSON? {
        switch value {
        case let value as Bool:
            return .boolean(value)
        case let value as String:
            return .string(value)
        case let value as Int:
            return .number(.integer(value))
        case let value as Double:
            return .number(.double(value))
        default:
            return .null
        }
    }
}

extension JSON {
    init(_ dict: [String: Any]) {
        var jsonized: [String: JSON] = [:]
        for (key, value) in dict {
            jsonized[key] = JSON.parse(value)
        }
        self = .object(jsonized)
    }
}
