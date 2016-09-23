//
//  MembersViewModel.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 22/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Keychain

class MembersViewModel {

    // MARK: - Data

    var members: [Member]?

    // MARK: - Authentication

    func logout() {
        Keychain.set(authenticationToken: nil)
    }

    // MARK: - Fetching

    func fetchMembers(completionHandler: @escaping (Result) -> ()) {
        let request = ActiveMembersRequest()
        Service().perform(request: request) { error, json in
            if let _ = error {
                completionHandler(.error("Unable to fetch the active members"))
                return
            }

            if let json = json as? NSArray {
                let members = Member.from(json)
                completionHandler(.success(members))
                return
            }

            completionHandler(.error("Incorrect data"))
        }
    }

    // MARK: - Selection

    func select(items: [Int]?) {
        
    }

}
