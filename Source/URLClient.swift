//
//  URLClient.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 7/20/15.
//  Copyright © 2015 PureSwift. All rights reserved.
//

public protocol URLClient {
    
    typealias Request: URLRequest
    
    typealias Response: URLResponse
    
    /// Checks whether the URL is valid for the protocol
    static func validURL(URL: URL) -> Bool
    
    func sendRequest(request: Request) throws -> Response
}