//
//  URLRequest.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 6/29/15.
//  Copyright © 2015 ColemanCDA. All rights reserved.
//

public protocol URLRequest {
    
    typealias URLType
    
    var URL: URLType { get }
    
    var timeoutInterval: TimeInterval { get }
}