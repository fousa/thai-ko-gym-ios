//
//  CreatePresenceRequest.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 23/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Alamofire
import Keychain

class CreatePresenceRequest: Request {

    // MARK: - Request

    var path: String {
        return "presences"
    }

    var method: HTTPMethod {
        return .post
    }

    var headers: HTTPHeaders? {
        return [
            "Authorization": "Token \(authorizationToken)"
        ]
    }

    var body: [String : Any]? {
        return [
            "presence": [
                "user_id": member.id,
                "present_at": formatter.string(from: date)
            ]
        ]
    }

    // MARK: - Stored properties

    private(set) var member: Member
    private(set) var date: Date

    // MARK: - Init

    init(member: Member, date: Date) {
        self.member = member
        self.date = date
    }

    // MARK: - Encoding

    private var authorizationToken: String {
        return Keychain.authenticationToken ?? ""
    }

    // MARK: - Formatter

    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "CET")
        return formatter
    }()
    
}

