//
//  AuthenticationRequest.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 21/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Alamofire

class AuthenticationRequest: Request {

    // MARK: - Request

    var path: String {
        return "authenticate"
    }

    var method: HTTPMethod {
        return .post
    }

    var headers: HTTPHeaders? {
        return [
            "Authorization": "Basic \(authorizationValue)"
        ]
    }

    // MARK: - Stored properties

    private(set) var email: String
    private(set) var password: String

    // MARK: - Init

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    // MARK: - Encoding

    private var authorizationValue: String {
        let concatinatedCredentials = "\(email):\(password)"
        let data = (concatinatedCredentials as NSString).data(using: String.Encoding.utf8.rawValue)
        return data!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }

}
