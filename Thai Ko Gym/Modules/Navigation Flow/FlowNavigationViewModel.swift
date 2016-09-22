//
//  FlowNavigationViewModel.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 18/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Keychain

class FlowNavigationViewModel {
    
    // MARK: - Authentication
    
    var authenticated: Bool {
        return Keychain.authenticationToken != nil
    }
    
}
