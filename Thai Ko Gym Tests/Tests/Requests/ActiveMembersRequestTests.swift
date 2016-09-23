//
//  ActiveMembersRequestTests.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 22/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import XCTest
import Alamofire
import Keychain

@testable import Thai_Ko_Gym

class ActiveMembersRequestTests: XCTestCase {

    // MARK: - Data

    private let request = ActiveMembersRequest()

    // MARK: - Tests

    func testsPath() {
        XCTAssertEqual(request.path, "users/active", "should return the correct path")
    }

    func testsMethod() {
        XCTAssertEqual(request.method, HTTPMethod.get, "should return the correct method")
    }

    func testsHeaders() {
        Keychain.set(authenticationToken: "123")

        XCTAssertEqual(request.headers?.count, 1, "should return the correct header count")
        XCTAssertEqual(request.headers?["Authorization"], "Token 123", "should return the correct authorization header")
    }

    func testBody() {
        XCTAssertNil(request.body, "should return an empty body")
    }
        
}
