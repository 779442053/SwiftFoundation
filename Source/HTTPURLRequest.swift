//
//  HTTPURLRequest.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 6/29/15.
//  Copyright © 2015 ColemanCDA. All rights reserved.
//

/** HTTP URL request. */
public struct HTTPURLRequest: URLRequest {
    
    public var URL: SwiftFoundation.URL
    
    public var timeoutInterval: TimeInterval = 30
    
    public var body: Data?
    
    public var headers: [String: String]
    
    public var method: HTTPMethod = .GET
    
    public var version: HTTPVersion = HTTPVersion()
}