//
//  Authentication.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 21/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Mapper

struct Authentication: Mappable {

    // MARK: - Properties

    let token: String

    // MARK: - Mapper

    init(map: Mapper) throws {
        try token = map.from("auth_token")
    }

}
