//
//  LIVRequestAdapter.swift
//  TAGit
//
//  Created by OSX on 7/12/19.
//  Copyright © 2019 Majestyk Apps. All rights reserved.
//

import Alamofire

class APIRequestAdapter: RequestAdapter {

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        if let token = AppManager.shared.currentUser?.token?.accessToken{
            var urlRequest = urlRequest
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            return urlRequest
        }
        return urlRequest
    }
}
