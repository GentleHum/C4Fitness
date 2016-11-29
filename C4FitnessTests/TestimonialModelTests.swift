//
//  TestimonialModelTests.swift
//  C4Fitness
//
//  Created by Owner on 11/17/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import XCTest
@testable import C4Fitness


class TestimonialModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Create_SetsName() {
        let testimonial = TestimonialModel(name: "Foo")
        XCTAssertEqual(testimonial.name, "Foo")
    }
    
    func test_Create_SetsLocation() {
        let testimonial = TestimonialModel(name: "Foo", location: "Bar")
        XCTAssertEqual(testimonial.location, "Bar")
    }
    
    func test_Create_SetsText() {
        let testimonial = TestimonialModel(name: "Foo", text: "Bar")
        XCTAssertEqual(testimonial.text, "Bar")
    }

    func test_Create_SetsSequenceNumber() {
        let testimonial = TestimonialModel(name: "Foo", sequenceNumber: 1)
        XCTAssertEqual(testimonial.sequenceNumber, 1)
    }
    
    func test_CreateWithJsonData_SetsValues() {
        let blogFields = ["name": "Foo",
                          "location": "Bar",
                          "text": "Dee",
                          "sequenceNumber": 1] as [String : Any]
        let jsonData: Dictionary<String, AnyObject> =  ["fields": blogFields as AnyObject]
        let testimonial = TestimonialModel()
        testimonial.set(jsonData: jsonData)
        XCTAssertEqual(testimonial.name, "Foo")
        XCTAssertEqual(testimonial.location, "Bar")
        XCTAssertEqual(testimonial.text, "Dee")
        XCTAssertEqual(testimonial.sequenceNumber, 1)
    }

    
}
