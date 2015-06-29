//
//  URLRequest.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 6/29/15.
//  Copyright © 2015 ColemanCDA. All rights reserved.
//

public protocol URLRequest {
    
    var URL: SwiftFoundation.URL { get }
    
    var timeoutInterval: TimeInterval { get }
}