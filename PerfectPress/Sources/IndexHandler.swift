//
//  IndexHandler.swift
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

#if os(Linux)
import Glibc
#else
import Darwin
#endif

struct IndexHandler {

    func loadPageContent() -> String {
        var post = "No matching post was found"
        let randomContent = ContentGenerator().generate()

        if let firstPost = randomContent["Test Post 1"] {
            post = firstPost as! String
        }
        let imageNumber = Int(arc4random_uniform(25) + 1)
        
        var finalContent = "<section id=\"content\"><div class=\"container\"><div class=\"row\"><div class=\"banner center-block\"><div><img src=\"/img/banner@2x.png\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-1.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-2.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-3.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-4.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-5.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div></div></div><div class=\"row\"><div class=\"col-xs-12\"><h1>"
        
        finalContent += "Test Post 1"
        finalContent += "</h1><img src=\""
        finalContent += "/img/random/random-\(imageNumber).jpg\" alt=\"Random Image \(imageNumber)\" class=\"alignleft feature-image img-responsive\" />"
        finalContent += "<div class=\"content\">\(post)</div>"
        finalContent += "</div></div</div></section>"

        return finalContent
    }

}
