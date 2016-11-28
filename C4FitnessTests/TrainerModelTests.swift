//
//  TrainerModelTests.swift
//  C4Fitness
//
//  Created by Owner on 11/17/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import XCTest
@testable import C4Fitness


class TrainerModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Create_SetsName() {
        let trainer = TrainerModel(name: "Foo")
        XCTAssertEqual(trainer.name, "Foo")
    }
    
    func test_Create_SetsTitle() {
        let trainer = TrainerModel(name: "Foo", title: "Bar")
        XCTAssertEqual(trainer.title, "Bar")
    }

    func test_Create_SetsDetails() {
        let trainer = TrainerModel(name: "Foo", details: "Bar")
        XCTAssertEqual(trainer.details, "Bar")
    }
    
    func test_Create_SetsImageName() {
        let trainer = TrainerModel(name: "Foo", imageName: "Bar")
        XCTAssertEqual(trainer.imageName, "Bar")
    }
   
    
}
