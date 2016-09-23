//
//  AuthenticationRequestTests.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 21/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import XCTest
import Alamofire

@testable import Thai_Ko_Gym

class AuthenticationRequestTests: XCTestCase {

    // MARK: - Data

    private let request = AuthenticationRequest(email: "jake@snake.be", password: "123")

    // MARK: - Tests
    
    func testsPath() {
        XCTAssertEqual(request.path, "authenticate", "should return the correct path")
    }

    func testsMethod() {
        XCTAssertEqual(request.method, HTTPMethod.post, "should return the correct method")
    }

    func testsHeaders() {
        XCTAssertEqual(request.headers?.count, 1, "should return the correct header count")
        XCTAssertEqual(request.headers?["Authorization"], "Basic amFrZUBzbmFrZS5iZToxMjM=", "should return the correct authorization header")
    }

    func testBody() {
        XCTAssertNil(request.body, "should return an empty body")
    }
    
}
