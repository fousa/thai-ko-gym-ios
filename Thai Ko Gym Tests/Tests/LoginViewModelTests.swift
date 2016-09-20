//
//  LoginViewModel.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 18/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import XCTest

@testable import Thai_Ko_Gym

class LoginViewModelTests: XCTestCase {
    
    func testEmptyPasswordString() {
        let viewModel = LoginViewModel()
        viewModel.authenticate(email: "jake@snake.be", password: "") { error in
            XCTAssertNotNil(error, "should return an error when the password is empty")
        }
    }
    
    func testEmptyEmailString() {
        let viewModel = LoginViewModel()
        viewModel.authenticate(email: "", password: "123") { error in
            XCTAssertNotNil(error, "should return an error when the email is empty")
        }
    }
    
    func testEmptyPassword() {
        let viewModel = LoginViewModel()
        viewModel.authenticate(email: "jake@snake.be", password: nil) { error in
            XCTAssertNotNil(error, "should return an error when the password is empty")
        }
    }
    
    func testEmptyEmail() {
        let viewModel = LoginViewModel()
        viewModel.authenticate(email: nil, password: "123") { error in
            XCTAssertNotNil(error, "should return an error when the email is empty")
        }
    }
    
}
