//
//  NSJSONSerialization.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 8/22/15.
//  Copyright © 2015 PureSwift. All rights reserved.
//

import Foundation

public extension NSJSONSerialization {
    
    public enum Value: RawRepresentable {
        
        case Null
        
        case String(NSString)
        
        case Number(NSNumber)
        
        case Array([NSJSONSerialization.Value])
        
        case Dictionary([NSString: NSJSONSerialization.Value])
        
        public init?(rawValue: AnyObject) {
            
            guard (rawValue as? NSNull) == nil else {
                
                self = .Null
                return
            }
            
            if let string = rawValue as? NSString {
                
                self = .String(string)
                return
            }
            
            if let number = rawValue as? NSNumber {
                
                self = .Number(number)
                return
            }
            
            if let rawArray = rawValue as? [AnyObject], let jsonArray: [NSJSONSerialization.Value] = NSJSONSerialization.Value.fromRawValues(rawArray) {
                
                self = .Array(jsonArray)
                return
            }
            
            if let rawDictionary = rawValue as? [NSString: AnyObject] {
                
                typealias FoundationValue = NSJSONSerialization.Value
                
                var jsonObject = [NSString: FoundationValue](minimumCapacity: rawDictionary.count)
                
                for (key, rawValue) in rawDictionary {
                    
                    guard let jsonValue = NSJSONSerialization.Value(rawValue: rawValue) else { return nil }
                    
                    jsonObject[key] = jsonValue
                }
                
                self = .Dictionary(jsonObject)
                return
            }
            
            return nil
        }
        
        public var rawValue: AnyObject {
            
            switch self {
                
            case .Null: return NSNull()
                
            case .String(let string): return string
                
            case .Number(let number): return number
                
            case .Array(let array): return array.rawValues
                
            case .Dictionary(let dictionary):
                
                var dictionaryValue = [NSString: AnyObject](minimumCapacity: dictionary.count)
                
                for (key, value) in dictionary {
                    
                    dictionaryValue[key] = value.rawValue
                }
                
                return dictionaryValue
            }
            
        }
    }
}

public extension JSON.Value {
    
    init(foundation: NSJSONSerialization.Value) {
        
        switch foundation {
            
        case .Null: self = .Null
            
        case .String(let value): self = JSON.Value.String(value as Swift.String)
            
        case .Number(let value): self = JSON.Value.Number(JSON.Number(rawValue: value)!)
            
        case .Array(let foundationArray):
            
            var jsonArray = JSONArray()
            
            for foundationValue in foundationArray {
                
                let jsonValue = JSON.Value(foundation: foundationValue)
                
                jsonArray.append(jsonValue)
            }
            
            self = .Array(jsonArray)
            
        case .Dictionary(let foundationDictionary):
            
            var jsonObject = JSONObject()
            
            for (key, foundationValue) in foundationDictionary {
                
                let jsonValue = JSON.Value(foundation: foundationValue)
                
                jsonObject[key as Swift.String] = jsonValue
            }
            
            self = .Object(jsonObject)
        }
    }
    
    func toFoundation() -> NSJSONSerialization.Value {
        
        typealias FoundationValue = NSJSONSerialization.Value
        
        switch self {
            
        case .Null: return NSJSONSerialization.Value.Null
            
        case .String(let string): return NSJSONSerialization.Value.String(string as NSString)
            
        case .Number(let number): return NSJSONSerialization.Value.Number(number.rawValue as! NSNumber)
            
        case .Array(let array):
            
            var foundationArray = [FoundationValue]()
            
            for jsonValue in array {
                
                let foundationValue = jsonValue.toFoundation()
                
                foundationArray.append(foundationValue)
            }
            
            return .Array(foundationArray)
            
        case .Object(let dictionary):
            
            var foundationDictionary = [NSString: FoundationValue](minimumCapacity: dictionary.count)
            
            for (key, value) in dictionary {
                
                let foundationValue = value.toFoundation()
                
                foundationDictionary[key as NSString] = foundationValue
            }
            
            return .Dictionary(foundationDictionary)
        }
    }
}