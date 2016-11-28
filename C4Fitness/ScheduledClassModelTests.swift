//
//  ScheduledClassModelTests.swift
//  C4Fitness
//
//  Created by Owner on 11/17/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import XCTest
@testable import C4Fitness


class ScheduledClassModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_Create_SetsName() {
        let scheduledClass = ScheduledClassModel(name: "Foo")
        XCTAssertEqual(scheduledClass.name, "Foo")
    }
    
    func test_Create_SetsDate() {
        let scheduledClass = ScheduledClassModel(name: "Foo", date: "Bar")
        XCTAssertEqual(scheduledClass.date, "Bar")
    }
    
    func test_Create_SetsStartTime() {
        let scheduledClass = ScheduledClassModel(name: "Foo", startTime: "Bar")
        XCTAssertEqual(scheduledClass.startTime, "Bar")
    }
    
    func test_Create_SetsEndTime() {
        let scheduledClass = ScheduledClassModel(name: "Foo", endTime: "Bar")
        XCTAssertEqual(scheduledClass.endTime, "Bar")
    }
    
    func test_Create_SetsTrainerName() {
        let scheduledClass = ScheduledClassModel(name: "Foo", trainerName: "Bar")
        XCTAssertEqual(scheduledClass.trainerName, "Bar")
    }
    
    
    
}
