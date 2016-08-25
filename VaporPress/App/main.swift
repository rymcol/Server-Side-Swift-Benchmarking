import Vapor
import HTTP

#if os(Linux)
public func arc4random_uniform(_ max: UInt32) -> Int {
    return Int(random() % Int(max + 1))
}
#endif

let drop = Droplet()

drop.get("/") { request in
    let header = CommonHandler().getHeader()
    let footer = CommonHandler().getFooter()
    let pageContent = IndexHandler().loadPageContent()
    let fullPage = header + footer + pageContent

    return Response(status: .ok, body: fullPage)
}

drop.get("blog") { request in
    let header = CommonHandler().getHeader()
    let footer = CommonHandler().getFooter()
    let pageContent = BlogHandler().loadPageContent()
    let fullPage = header + footer + pageContent

    return Response(status: .ok, body: fullPage)
}

drop.get("json") { request in

    return try JSON(JSONCreator().generateJSON())
}

let port = drop.config["app", "port", "host"].int ?? 80

// Print what link to visit for default port
print("Visit http://localhost:\(port)")
drop.serve()
