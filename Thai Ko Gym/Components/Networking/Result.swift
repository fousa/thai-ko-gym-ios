//
//  Result.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 22/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Mapper

enum Result {
    case error(String)
    case success(Any?)

    // MARK: - Utility

    var object: Mappable? {
        switch self {
        case .success(let data):
            return data as? Mappable
        default:
            return nil
        }
    }

    var objects: [Mappable]? {
        switch self {
        case .success(let data):
            return data as? [Mappable]
        default:
            return nil
        }
    }

    var succeeded: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
}
