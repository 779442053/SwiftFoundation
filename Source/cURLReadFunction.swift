//
//  cURLReadFunction.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 8/4/15.
//  Copyright © 2015 PureSwift. All rights reserved.
//

import cURL

public final class curlReadFunctionStorage {
    
    public let data: Data
    
    public var currentIndex = 0
    
    public init(data: Data) {
        
        self.data = data
    }
}

public func curlReadFunction(pointer: UnsafeMutablePointer<Int8>, size: Int, nmemb: Int, readData: UnsafeMutablePointer<Void>) -> Int {
    
    let storage = unsafeBitCast(readData, curlReadFunctionStorage.self)
    
    let data = storage.data
    
    let currentIndex = storage.currentIndex
    
    guard (size * nmemb) > 0 else { return Int(false) }
    
    guard currentIndex < data.count else { return Int(false) }
    
    let byte = data[currentIndex]
    
    let char = CChar(byte)
    
    pointer.memory = char
    
    storage.currentIndex++
    
    return Int(true)
}

