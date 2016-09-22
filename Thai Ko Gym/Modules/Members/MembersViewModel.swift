//
//  MembersViewModel.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 22/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Keychain

class MembersViewModel {

    // MARK: - Authentication

    func logout() {
        Keychain.set(authenticationToken: nil)
    }

}
