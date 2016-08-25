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
    route.get("/") { request in

        let header = CommonHandler().getHeader()
        let footer = CommonHandler().getFooter()
        let body = IndexHandler().loadPageContent()
        let indexPage = header + body + footer

        return Response(body: indexPage)
    }

    route.get("blog") { request in

        let header = CommonHandler().getHeader()
        let footer = CommonHandler().getFooter()
        let body = BlogHandler().loadPageContent()
        let blogPage = header + body + footer

        return Response(body: blogPage)
    }

    route.get("json") { request in

        let jsonString = JSON(JSONCreator().generateJSON())

        return Response(body: "\(jsonString)")
    }

    //serves static files
    route.get("/*", responder: ThreadedFileResponder(path: "webroot/"))
}

try HTTPServer.Server(host: "0.0.0.0", port: 8282, responder: app).start()
