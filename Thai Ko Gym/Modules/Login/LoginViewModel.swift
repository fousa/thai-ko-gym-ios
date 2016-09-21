//
//  LoginViewModel.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 18/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

enum LoginError: Error {
    case incorrectInput
}

class LoginViewModel {
    
    // MARK: - Authenticate
    
    func authenticate(email: String?, password: String?, completionHandler: @escaping (Error?) -> ()) {
        guard
            let email = email,
            let password = password,
            !email.isEmpty,
            !password.isEmpty else {
            completionHandler(LoginError.incorrectInput)
            return
        }

        let request = AuthenticationRequest(email: email, password: password)
        Service().perform(request: request) { error in
            completionHandler(error)
        }
    }
    
}
