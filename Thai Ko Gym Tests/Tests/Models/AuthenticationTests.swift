//
//  AuthenticationTests.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 21/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import XCTest
import Mapper

@testable import Thai_Ko_Gym

class AuthenticationTests: XCTestCase {
    
    // MARK: - Tests

    func testTokenMapping() {
        let json = ["auth_token": "123"] as NSDictionary
        let authentication = Authentication.from(json)
        XCTAssertEqual(authentication?.token, json["auth_token"] as? String, "should return the correct authentication token")
    }

    func testInvalidTokenMapping() {
        let json = [:] as NSDictionary
        let authentication = Authentication.from(json)
        XCTAssertNil(authentication, "should return an invalid authentication object")
    }
    
}
