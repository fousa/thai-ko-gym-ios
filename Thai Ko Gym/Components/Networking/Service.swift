//
//  Service.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 21/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Alamofire

class Service {

    // MARK: - Request

    func perform(request: Request, completionHandler: @escaping (Error?, Any?) -> ()) {
        Alamofire.request(request, method: request.method, parameters: request.body, encoding: JSONEncoding.default, headers: request.headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let json):
                    completionHandler(nil, json)
                case .failure(let error):
                    completionHandler(error, nil)
                }
        }
    }

}
