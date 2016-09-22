//
//  LoginViewModel.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 18/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Keychain

enum LoginResult {
    case error(String)
    case success

    // MARK: - Utility

    var succeeded: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
}

class LoginViewModel {
    
    // MARK: - Authenticate
    
    func authenticate(email: String?, password: String?, completionHandler: @escaping (Result) -> ()) {
        guard
            let email = email,
            let password = password,
            !email.isEmpty,
            !password.isEmpty else {
            completionHandler(.error("Incorrect input"))
            return
        }

        let request = AuthenticationRequest(email: email, password: password)
        Service().perform(request: request) { error, json in
            if let _ = error {
                completionHandler(.error("Incorrect credentials"))
                return
            }

            if let json = json as? NSDictionary {
                let authentication = Authentication.from(json)
                print("🔑 Authenticated")
                Keychain.set(authenticationToken: authentication?.token)
                completionHandler(.success(nil))
                return
            }

            completionHandler(.error("Incorrect credentials"))
        }
    }
    
}
