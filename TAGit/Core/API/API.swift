//
//  APIManager.swift
//  ActionIWS
//
//  Created by OSX on 7/12/19.
//  Copyright © 2019 Majestyk Apps. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire
import ObjectMapper

enum ApiError: Error {
    case unknown
    case invalidJSON
    case message(reason: String)
}

final class API {
    
    static let shared = API()
    private var manager: SessionManager

    private init() {
        self.manager = SessionManager(configuration: URLSessionConfiguration.default)
        self.manager.retrier = APIRequestRetrier()
        self.manager.adapter = APIRequestAdapter()
    }

    func request(url: URLConvertible,
                 params: Parameters,
                 method: HTTPMethod = .get,
                 secretNeeded: Bool = false,
                 encoding: ParameterEncoding = URLEncoding.default,
                 headers: HTTPHeaders? = nil) -> Promise<Any> {
        
        return Promise(resolver: { seal in
            var parameters = params
            if secretNeeded {
                parameters["client_id"] = ClientCredentials.id
                parameters["client_secret"] = ClientCredentials.secret
            }

            ProgressHUD.show()
            manager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
                .validate(statusCode: 200..<600).responseJSON { response in
                ProgressHUD.dismiss()
                    
                guard let json = response.result.value as? [String: Any] else {
                    seal.reject(ApiError.invalidJSON)
                    return
                }
                
                if let serverResponse = ServerResponse(JSON: json) {
                    if serverResponse.success, let jsonObject = json["data"] {
                        seal.fulfill(jsonObject)
                    }
                    else {
                        seal.reject(ApiError.message(reason: serverResponse.message))
                    }
                }
                else {
                    seal.reject(ApiError.unknown)
                }
            }
        })
    }
    
    public func refreshToken() -> Promise<Token> {
        return Promise(resolver: { (seal) in
            guard let token = AppManager.shared.currentUser?.token?.refreshToken else {
                seal.reject(ApiError.message(reason: "user_not_authorized".localized()))
                return
            }
            
            let parameters: Parameters = ["refresh_token" : token]
            self.request(url: Paths.Token.refresh, params: parameters, method: .post, secretNeeded: true)
                .compactMap({ (data) -> Token? in
                    return Token.map(json: data)
                })
                .done({ token in
                    seal.fulfill(token)
                })
                .catch({ (error) in
                    seal.reject(error)
                })
        })
    }
    
    public func signUp(email: String, password: String, fullName: String = "") -> Promise<User> {
        return Promise(resolver: { (seal) in
            let parameters = [
                "name" : fullName,
                "password" : password,
                "password_confirmation" : password,
                "email" : email
            ]

            self.request(url: Paths.Me.signUp, params: parameters, method: .post, secretNeeded: true)
                .compactMap({ (data) -> User? in
                    return User.map(json: data)
                })
                .done({ value in
                    seal.fulfill(value)
                })
                .catch({ (error) in
                    seal.reject(error)
                })
        })
    }
    
    public func signIn(email: String, password: String) -> Promise<User> {
        return Promise(resolver: { (seal) in
            let parameters = [
                "password" : password,
                "email" : email
            ]
            
            self.request(url: Paths.Me.signIn, params: parameters, method: .post, secretNeeded: true)
                .compactMap({ (data) -> User? in
                    return User.map(json: data)
                })
                .done({ value in
                    seal.fulfill(value)
                })
                .catch({ (error) in
                    seal.reject(error)
                })
        })
    }
    
    public func resetPassword(email: String) -> Promise<Bool> {
        return Promise(resolver: { (seal) in
            let parameters = [
                "email" : email
            ]
            
            self.request(url: Paths.Password.reset, params: parameters, method: .post, secretNeeded: true)
                .done({ value in
                    seal.fulfill(true)
                })
                .catch({ (error) in
                    seal.reject(error)
                })
        })
    }
    
    public func logout(email: String) -> Promise<Bool> {
        return Promise(resolver: { (seal) in
            self.request(url: Paths.Me.logOut, params: [:], method: .get, secretNeeded: false)
                .done({ value in
                    seal.fulfill(true)
                })
                .catch({ (error) in
                    seal.reject(error)
                })
        })
    }
    
    public func getCategories(page: Int = 1, limit: Int = 100, sortBy: String = "name", sortOrder: String = "asc") -> Promise<[CategoryModel]> {
        return Promise(resolver: { (seal) in
            let parameters: Parameters = [
                "limit" : limit,
                "page" : page,
                "sort_by" : sortBy,
                "sort_order": sortOrder
            ]
            
            self.request(url: Paths.Category.categories, params: parameters, method: .get, secretNeeded: false)
                .compactMap({ (data) -> [CategoryModel]? in
                    guard let jsonArray = data as? [Any] else {
                        return nil
                    }
                    return jsonArray.compactMap({ (json) -> CategoryModel? in
                        let mapper = Mapper<CategoryModel>()
                        if let category = mapper.map(JSONObject: json) {
                            return category
                        }
                        return nil
                    })
                })
                .done({ value in
                    seal.fulfill(value)
                })
                .catch({ (error) in
                    seal.reject(error)
                })
        })
    }
    
    public func getCategory(by categoryId: Int, page: Int = 1, limit: Int = 100, sortBy: String = "name", sortOrder: String = "asc") -> Promise<CategoryModel> {
        let parameters: Parameters = [
            "limit" : limit,
            "page" : page,
            "sort_by" : sortBy,
            "sort_order": sortOrder
        ]
        return Promise(resolver: { (seal) in
            self.request(url: String(format: Paths.Category.byId, categoryId), params: parameters, method: .get, secretNeeded: false)
                .compactMap({ (data) -> CategoryModel? in
                    return CategoryModel.map(json: data)
                })
                .done({ value in
                    seal.fulfill(value)
                })
                .catch({ (error) in
                    seal.reject(error)
                })
        })
    }
    
    public func selectCategories(selectedIds: [String]) -> Promise<Bool> {
        let ids = selectedIds.joined(separator: ",")
        let parameters: Parameters = [
            "ids" : ids
        ]
        return Promise(resolver: { (seal) in
            self.request(url: Paths.Category.selectCategories, params: parameters, method: .get, secretNeeded: false)
                .done({ value in
                    seal.fulfill(true)
                })
                .catch({ (error) in
                    seal.reject(error)
                })
        })
    }
    
    public func getProducts(page: Int = 1, limit: Int = 100, sortBy: String = "created_at", sortOrder: String = "desc") -> Promise<[ProductModel]> {
        return Promise(resolver: { (seal) in
            let parameters: Parameters = [
                "limit" : limit,
                "page" : page,
                "sort_by" : sortBy,
                "sort_order": sortOrder
            ]
            
            self.request(url: Paths.Product.products, params: parameters, method: .get, secretNeeded: false)
                .compactMap({ (data) -> [ProductModel]? in
                    guard let jsonArray = data as? [Any] else {
                        return nil
                    }
                    return jsonArray.compactMap({ (json) -> ProductModel? in
                        let mapper = Mapper<ProductModel>()
                        if let product = mapper.map(JSONObject: json) {
                            return product
                        }
                        return nil
                    })
                })
                .done({ value in
                    seal.fulfill(value)
                })
                .catch({ (error) in
                    seal.reject(error)
                })
        })
    }
    
    public func getEpisodes(by showId: Int, page: Int = 1, limit: Int = 100, sortBy: String = "created_at", sortOrder: String = "desc") -> Promise<[EpisodeModel]> {
        let parameters: Parameters = [
            "limit" : limit,
            "page" : page,
            "sort_by" : sortBy,
            "sort_order": sortOrder
        ]
        return Promise(resolver: { (seal) in
            self.request(url: String(format: Paths.Episode.episodes, showId), params: parameters, method: .get, secretNeeded: false)
                .compactMap({ (data) -> [EpisodeModel]? in
                    guard let jsonArray = data as? [Any] else {
                        return nil
                    }
                    return jsonArray.compactMap({ (json) -> EpisodeModel? in
                        let mapper = Mapper<EpisodeModel>()
                        if let episode = mapper.map(JSONObject: json) {
                            return episode
                        }
                        return nil
                    })
                })
                .done({ value in
                    seal.fulfill(value)
                })
                .catch({ (error) in
                    seal.reject(error)
                })
        })
    }
    
    public func getEpisode(by episodeId: Int) -> Promise<EpisodeModel> {
        return Promise(resolver: { (seal) in
            self.request(url: String(format: Paths.Episode.byId, episodeId), params: [:], method: .get, secretNeeded: false)
                .compactMap({ (data) -> EpisodeModel? in
                    return EpisodeModel.map(json: data)
                })
                .done({ value in
                    seal.fulfill(value)
                })
                .catch({ (error) in
                    seal.reject(error)
                })
        })
    }
    
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "unknown error"
        case .invalidJSON:
            return "invalid json"
        case .message(let reason): return reason
        }
    }
}


