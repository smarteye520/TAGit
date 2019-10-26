//
//  APIConstant.swift
//  TAGit
//
//  Created by OSX on 7/12/19.
//  Copyright © 2019 Majestyk Apps. All rights reserved.
//

import Foundation
import ObjectMapper

struct Environment {
    public static let current: Options = .development
    
    enum Options {
        case development, production
    }
}

struct Paths {
    private static var Base: String {
        get {
            switch Environment.current {
            case .development:
                return "http://tagit-dev-apisvc-436291876.us-east-1.elb.amazonaws.com/v1"
            case .production:
                return "http://tagit-dev-apisvc-436291876.us-east-1.elb.amazonaws.com/v1"
            }
        }
    }
    struct Token {
        public static let refresh = "\(Base)/refresh-token"
    }
    struct ImagePath {
        public static let path =  "http://tagit-dev-apisvc-436291876.us-east-1.elb.amazonaws.com%@"
    }
    struct Me {
        public static let signIn =  "\(Base)/login"
        public static let signUp =  "\(Base)/signup"
        public static let logOut =  "\(Base)/logout"
        public static let me =      "\(Base)/me"
        public static let profile = "\(Base)/my/profile"
    }
        
    struct Password {
        public static let reset = "\(Base)/password/reset"
    }
    
    struct Category {
        public static let categories = "\(Base)/categories"
        public static let byId = "\(Base)/categories/%d"
        public static let selectCategories = "\(Base)/categories/select"
    }
    
    struct Product {
        public static let products = "\(Base)/products"
        public static let byId = "\(Base)/products/%d"
        public static let favorite = "\(Base)/products/%d/favorite"
    }
    
    struct Show {
        public static let shows = "\(Base)/shows"
        public static let byId = "\(Base)/shows/%d"
    }
    
    struct Episode {
        public static let episodes = "\(Base)/shows/%d/episodes"
        public static let byId = "\(Base)/episodes/%d"
    }
}

struct ClientCredentials {
    public static var id: String {
        switch Environment.current {
        case .development:
            return "pKChUB5i9Pni8s6NFtpO2vHbDyuINryxYtCp5ggX"
        case .production:
            return "pKChUB5i9Pni8s6NFtpO2vHbDyuINryxYtCp5ggX"
        }
    }
    public static var secret: String {
        switch Environment.current {
        case .development:
            return "1IP3Wg6atVLoE2MmOJkpTJcCgmmPXdO7ZISA9Ye6"
        case .production:
            return "1IP3Wg6atVLoE2MmOJkpTJcCgmmPXdO7ZISA9Ye6"
        }
    }
}

struct ServerResponse: Mappable {
    var success: Bool!
    var message: String!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
    }
}

