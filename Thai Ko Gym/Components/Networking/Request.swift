//
//  Request.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 21/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Alamofire

protocol Request: URLConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
}

extension Request {
    var baseURLString: URL {
        return URL(string: "https://thai-ko-gym-staging.herokuapp.com/api")!
    }

    func asURL() throws -> URL {
        return baseURLString.appendingPathComponent(path)
    }
}
