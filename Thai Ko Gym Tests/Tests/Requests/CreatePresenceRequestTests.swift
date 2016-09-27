//
//  CreatePresenceRequestTests.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 23/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import XCTest
import Mapper
import Alamofire
import Keychain

@testable import Thai_Ko_Gym

class CreatePresenceRequestTests: XCTestCase {

    // MARK: - Data

    private let json = [
        "id": 123,
        "first_name": "Jake",
        "last_name": "the Snake"
    ] as NSDictionary

    private lazy var request: CreatePresenceRequest = { [unowned self] in
        let member = Member.from(self.json)!
        let date = Date(timeIntervalSince1970: 60*60*24*361*40)
        return CreatePresenceRequest(member: member, date: date)
    }()

    // MARK: - Tests

    func testsPath() {
        XCTAssertEqual(request.path, "presences", "should return the correct path")
    }

    func testsMethod() {
        XCTAssertEqual(request.method, HTTPMethod.post, "should return the correct method")
    }

    func testsHeaders() {
        Keychain.set(authenticationToken: "123")

        XCTAssertEqual(request.headers?.count, 1, "should return the correct header count")
        XCTAssertEqual(request.headers?["Authorization"], "Token 123", "should return the correct authorization header")
    }

    func testBody() {
        XCTAssertNotNil(request.body, "should return an empty body")
    }

    func testBodyRootElement() {
        XCTAssertNotNil(request.body?["presence"], "should return an empty body")
    }

    func testBodyUserIdElement() {
        let presenceBody = request.body?["presence"] as? [String: Any]
        XCTAssertEqual(presenceBody?["user_id"] as? Int, 123, "should return the correct user id")
    }

    func testBodyPresentAtElement() {
        let presenceBody = request.body?["presence"] as? [String: Any]
        XCTAssertEqual(presenceBody?["present_at"] as? String, "2009-07-15", "should return the correct presence date")
    }
    
}
