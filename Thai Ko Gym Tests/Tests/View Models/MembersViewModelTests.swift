//
//  MembersViewModelTests.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 22/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import XCTest
import Keychain

@testable import Thai_Ko_Gym

class MembersViewModelTests: XCTestCase {

    // MARK: - Data

    let viewModel = MembersViewModel()

    // MARK: - Tests

    func testLogout() {
        Keychain.set(authenticationToken: "123")
        viewModel.logout()
        XCTAssertNil(Keychain.authenticationToken, "should not be authenticated")
    }

    
}
