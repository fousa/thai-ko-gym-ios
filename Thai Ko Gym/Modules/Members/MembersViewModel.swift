//
//  MembersViewModel.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 22/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Keychain
import Bond

class MembersViewModel {

    // MARK: - Observables

    let hasSelection = Observable(false)

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

    // MARK: - Saving

    func save(items: [Int]?, completionHandler: @escaping (Result) -> ()) {
        guard
            let items = items,
            let members = members,
            items.count > 0 else {
            completionHandler(.error("No members were selected"))
            return
        }

        let selectedMembers = items.map { members[$0] }
        var success = true

        let group = DispatchGroup()
        DispatchQueue(label: "presences", qos: .background).async {
            for member in selectedMembers {
                group.enter()

                self.save(member: member, complectionHandler: { saveSuccessful in
                    if !saveSuccessful {
                        success = false
                    }

                    group.leave()
                })
            }
            group.wait()
            DispatchQueue.main.async {
                if success {
                    completionHandler(.success(true))
                } else {
                    completionHandler(.error("Unable to create the member's presence"))
                }
            }
        }
    }

    private func save(member: Member, complectionHandler: @escaping (Bool) -> ()) {
        print("✅ Start saving presence for member", member.name)

        let request = CreatePresenceRequest(member: member, date: Date())
        Service().perform(request: request) { error, json in
            if let _ = error {
                complectionHandler(false)
            } else {
                print("✅ Saved presence for member", member.name)
                complectionHandler(false)
            }
        }
    }

    // MARK: - Selection

    func select(items: [Int]?) {
        hasSelection.value = items?.count ?? 0 > 0
    }

}
