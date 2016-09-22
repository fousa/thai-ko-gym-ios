//
//  Member.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 22/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Mapper

struct Member: Mappable {

    // MARK: - Properties

    let id: Int
    let firstName: String
    let lastName: String

    // MARK: - Mapper

    init(map: Mapper) throws {
        try id = map.from("id")
        try firstName = map.from("first_name")
        try lastName = map.from("last_name")
    }

    // MARK: - Getters

    var name: String {
        return "\(firstName) \(lastName)"
    }
    
}
