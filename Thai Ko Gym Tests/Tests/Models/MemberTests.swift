//
//  MemberTests.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 22/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import XCTest
import Mapper

@testable import Thai_Ko_Gym

class MemberTests: XCTestCase {

    // MARK: - Data

    private let json = [
        "id": 123,
        "first_name": "Jake",
        "last_name": "the Snake"
    ] as NSDictionary

    // MARK: - Tests

    func testIdNameMapping() {
        let member = Member.from(json)
        XCTAssertEqual(member?.id, json["id"] as? Int, "should return the correct id")
    }

    func testFirstNameMapping() {
        let member = Member.from(json)
        XCTAssertEqual(member?.firstName, json["first_name"] as? String, "should return the correct first name")
    }

    func testLastNameMapping() {
        let member = Member.from(json)
        XCTAssertEqual(member?.lastName, json["last_name"] as? String, "should return the correct last name")
    }

    func testInvalidMapping() {
        let json = [:] as NSDictionary
        let member = Member.from(json)
        XCTAssertNil(member, "should return an invalid member object")
    }

    func testName() {
        let member = Member.from(json)
        XCTAssertEqual(member?.name, "Jake the Snake", "should return the correct name")
    }

}
