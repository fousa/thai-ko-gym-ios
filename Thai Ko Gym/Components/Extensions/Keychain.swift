//
//  Keychain.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 22/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Keychain

extension Keychain {

    // MARK: - Internal

    private static let authenticationTokenKey = "authenticationTokenKey"

    // MARK: - Authentication Token

    static func set(authenticationToken: String?) {
        if let authenticationToken = authenticationToken {
            let _ = save(authenticationToken, forKey: authenticationTokenKey)
        } else {
            let _ = delete(authenticationTokenKey)
        }
    }

    static var authenticationToken: String? {
        return load(authenticationTokenKey)
    }

}
