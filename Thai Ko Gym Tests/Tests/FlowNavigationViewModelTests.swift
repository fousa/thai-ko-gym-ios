//
//  Thai_Ko_Gym_Tests.swift
//  Thai Ko Gym Tests
//
//  Created by Jelle Vandebeeck on 18/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import XCTest

@testable import Thai_Ko_Gym

class FlowNavigationViewModelTests: XCTestCase {
    
    func testAuthenticated() {
        let viewModel = FlowNavigationViewModel()
        assert(viewModel.authenticated, "should be authenticated")
    }
    
}
