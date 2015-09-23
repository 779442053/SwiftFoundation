//
//  StringTests.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 9/23/15.
//  Copyright © 2015 PureSwift. All rights reserved.
//

import XCTest

class StringTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testUTF8Data() {
        
        let string = "Test Text 😃"
        
        let data = (string as NSString).dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!.arrayOfBytes()
        
        let decodedString = String(UTF8: data)
        
        XCTAssert(string == decodedString, "\(string) == \(decodedString)")
    }

}
