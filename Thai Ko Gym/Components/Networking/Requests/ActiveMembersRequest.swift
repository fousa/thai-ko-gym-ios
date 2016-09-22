//
//  MembersRequest.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 22/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Alamofire
import Keychain

class ActiveMembersRequest: Request {

    // MARK: - Request

    var path: String {
        return "users/active"
    }

    var method: HTTPMethod {
        return .get
    }

    var headers: HTTPHeaders? {
        return [
            "Authorization": "Token \(authorizationToken)"
        ]
    }

    // MARK: - Encoding

    private var authorizationToken: String {
        return Keychain.authenticationToken ?? ""
    }

}
