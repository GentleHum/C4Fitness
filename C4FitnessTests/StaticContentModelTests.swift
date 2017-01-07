//
//  StaticContentModelTests.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/29/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import XCTest
@testable import C4Fitness

class StaticContentModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Create_SetsText() {
        let testimonial = TestimonialModel(name: "Foo", text: "Bar")
        XCTAssertEqual(testimonial.text, "Bar")
    }
    
    func test_Create_SetsLabel() {
        let staticContent = StaticContentModel(label: "Foo")
        XCTAssertEqual(staticContent.label, "Foo")
    }
    
    func test_CreateWithJsonData_SetsValues() {
        let staticContentItems = ["label": "Foo",
                                  "text": "Bar"] as [String : Any]
        let jsonData: JSONDictionary =  ["fields": staticContentItems as AnyObject]
        let staticContent = StaticContentModel(jsonData: jsonData)
        XCTAssertEqual(staticContent.label, "Foo")
        XCTAssertEqual(staticContent.text, "Bar")
    }
    

    
}
