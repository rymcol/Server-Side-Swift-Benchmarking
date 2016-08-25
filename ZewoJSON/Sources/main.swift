import Zewo
import HTTPServer
import Router
import JSON


#if os(Linux)
public func arc4random_uniform(_ max: UInt32) -> Int {
    return Int(random() % Int(max + 1))
}
#endif

let app = Router { route in
    route.get("json") { request in

        let jsonString = JSON(JSONCreator().generateJSON())

        return Response(body: "\(jsonString)")
    }
}

try HTTPServer.Server(host: "0.0.0.0", port: 8282, responder: app).start()
