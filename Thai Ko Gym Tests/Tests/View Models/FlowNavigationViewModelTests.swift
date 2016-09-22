//
//  Thai_Ko_Gym_Tests.swift
//  Thai Ko Gym Tests
//
//  Created by Jelle Vandebeeck on 18/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import XCTest
import Keychain

@testable import Thai_Ko_Gym

class FlowNavigationViewModelTests: XCTestCase {

    // MARK: - Data

    let viewModel = FlowNavigationViewModel()

    // MARK: - Tests

    func testAuthenticated() {
        Keychain.set(authenticationToken: "123")
        XCTAssertTrue(viewModel.authenticated, "should be authenticated")
    }

    func testNotAuthenticated() {
        Keychain.set(authenticationToken: nil)
        XCTAssertFalse(viewModel.authenticated, "should not be authenticated")
    }
    
}
