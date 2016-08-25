//
//  main.swift
//  PerfectPress
//
//  Created by Ryan Collins on 6/9/16.
//  Copyright (C) 2016 Ryan M. Collins.
//
//===----------------------------------------------------------------------===//
//
// This source file has been modified from the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTPServer

#if os(Linux)
public func arc4random_uniform(_ max: UInt32) -> Int {
    return Int(random() % Int(max + 1))
}
#endif

// Create webroot
let webRoot = "./webroot/"
try Dir(webRoot).create()

do {
	let server = HTTPServer()

	// Set a listen port of 8181
	server.serverPort = 8181

	let routes = makeRoutes()
	server.addRoutes(routes)

	// Set a document root.
	// This is optional. If you do not want to serve static content then do not set this.
	server.documentRoot = "./webroot"

    server.serverAddress = Config().ip

	// Gather command line options and further configure the server.
	// Run the server with --help to see the list of supported arguments.
	// Command line arguments will supplant any of the values set above.
	configureServer(server)

	// Launch the HTTP server.
	try server.start()

} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
