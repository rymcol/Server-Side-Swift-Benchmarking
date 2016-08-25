//
//  routing.swift
//  PerfectPress
//
//  Created by Ryan Collins on 6/9/16.
//  Copyright (C) 2016 Ryan M. Collins.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the PerfectPress open source blog project
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP

func makeRoutes() -> Routes {

    var routes = Routes()

    routes.add(method: .get, uris: ["/", "index.html"], handler: indexHandler)

    routes.add(method: .get, uris: ["blog"], handler: blogHandler)

    routes.add(method: .get, uris: ["json"], handler: JSONHandler)

    return routes
}

func indexHandler(request: HTTPRequest, _ response: HTTPResponse) {
    let header = CommonHandler().getHeader()
    let footer = CommonHandler().getFooter()
    let body = IndexHandler().loadPageContent()
    let indexPage = header + body + footer

    response.setHeader(.contentType, value: "text/html; charset=utf-8")
    response.appendBody(string: indexPage)
    response.completed()
}

func blogHandler(request: HTTPRequest, _ response: HTTPResponse) {
    let header = CommonHandler().getHeader()
    let footer = CommonHandler().getFooter()
    let body = BlogPageHandler().loadPageContent()
    let blogPage = header + body + footer

    response.setHeader(.contentType, value: "text/html; charset=utf-8")
    response.appendBody(string: blogPage)
    response.completed()
}

func JSONHandler(request: HTTPRequest, _ response: HTTPResponse) {

    let JSONData = JSONCreator().generateJSON()

    do {
        response.setHeader(.contentType, value: "application/json; charset=utf-8")
        try response.setBody(json: JSONData)
    } catch {
        response.appendBody(string: "JSON Failed")
    }
    response.completed()
}
