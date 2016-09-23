//
//  ResultTests.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 23/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import XCTest

@testable import Thai_Ko_Gym

class ResultTests: XCTestCase {

    // MARK: - Data

    private let json = [
        "id": 123,
        "first_name": "Jake",
        "last_name": "the Snake"
        ] as NSDictionary

    // MARK: - Tests
    
    func testError() {
        let result = Result.error("An error")
        XCTAssertEqual(result.succeeded, false, "should not be succeeded")
    }

    func testSuccess() {
        let result = Result.success(1)
        XCTAssertEqual(result.succeeded, true, "should succeed")
        XCTAssertNil(result.objects, "should not return objects")
        XCTAssertNil(result.object, "should not return an object")
    }

    func testObject() {
        let object = Member.from(json)

        let result = Result.success(object)
        XCTAssertEqual(result.succeeded, true, "should succeed")
        XCTAssertNotNil(result.object, "should return an object")
        XCTAssertNil(result.objects, "should not return objects")
    }

    func testObjects() {
        let objects = [Member.from(json)]

        let result = Result.success(objects)
        XCTAssertEqual(result.succeeded, true, "should succeed")
        XCTAssertNil(result.object, "should not return an object")
        XCTAssertNotNil(result.objects, "should return objects")
    }
    
}
