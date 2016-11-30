//
//  FitnessClassModelTests.swift
//  C4Fitness
//
//  Created by Owner on 11/23/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import XCTest
@testable import C4Fitness

class FitnessClassModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Create_SetsName() {
        let fitnessClass = FitnessClassModel(name: "Foo")
        XCTAssertEqual(fitnessClass.name, "Foo")
    }
    
    func test_Create_SetsDescription() {
        let fitnessClass = FitnessClassModel(name: "Foo", descriptionString: "Bar")
        XCTAssertEqual(fitnessClass.descriptionString, "Bar")
    }
    
    func test_Create_SetsFootnote() {
        let fitnessClass = FitnessClassModel(name: "Foo", footnote: "Bar")
        XCTAssertEqual(fitnessClass.footnote, "Bar")
    }
    
    func test_Create_SetsDuration() {
        let fitnessClass = FitnessClassModel(name: "Foo", duration: "Bar")
        XCTAssertEqual(fitnessClass.duration, "Bar")
    }
    
    func test_Create_SetsSequenceNumber() {
        let fitnessClass = FitnessClassModel(name: "Foo", sequenceNumber: 1)
        XCTAssertEqual(fitnessClass.sequenceNumber, 1)
    }
    
    func test_CreateWithJsonData_SetsValues() {
        let fitnessClasses = ["name": "Foo",
                              "description": "Bar",
                              "footnote": "Dee",
                              "duration": "45 min",
                              "sequenceNumber": 1] as [String : Any]
        let jsonData: Dictionary<String, AnyObject> =  ["fields": fitnessClasses as AnyObject]
        let fitnessClass = FitnessClassModel()
        fitnessClass.set(jsonData: jsonData)
        XCTAssertEqual(fitnessClass.name, "Foo")
        XCTAssertEqual(fitnessClass.descriptionString, "Bar")
        XCTAssertEqual(fitnessClass.footnote, "Dee")
        XCTAssertEqual(fitnessClass.duration, "45 min")
        XCTAssertEqual(fitnessClass.sequenceNumber, 1)
    }
    
}
