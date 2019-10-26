//
//  User.swift
//  TAGit
//
//  Created by OSX on 7/12/19.
//  Copyright © 2019 Majestyk Apps. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON

class User: BaseObject {
    // User property
    var name: String?
    var email: String?
    var network: String?
    var network_id: Int?
    var birthstamp: String?
    var birthday: Date?
    
    //Account Settings
    var isNotifyReminders: Bool?
    var isNotifyNewEpisodes: Bool?
    var isNotifyNewMerchandise: Bool?
    
    //Match Preference

    //Location
    var device_id: String?
    var channel_id: String?
    var emailVerifiedAt: String?
    
    //Tokens
    var token: Token?
    
    override func mapping(map: Map) {
        super.mapping(map: map)

        name                   <- map["name"]
        email                       <- map["email"]
        network                        <- map["network"]
        network_id                       <- (map["network_id"], IntTransform.shared)
        birthstamp                  <- map["birthstamp"]
        birthday                    <- (map["birthday"], DateFormatTransform.shared)
        device_id                 <- map["device_id"]
        channel_id                <- map["channel_id"]
        emailVerifiedAt                  <- map["email_verified_at"]
        isNotifyReminders              <- (map["is_notify_reminders"], BoolTransform.shared)
        isNotifyNewEpisodes           <- (map["is_notify_new_episodes"], BoolTransform.shared)
        isNotifyNewMerchandise              <- (map["is_notify_new_merchandise"], BoolTransform.shared)
        token                       <- map["tokens"]
    }
    
    override func attach(_ model: BaseObject) {
        super.attach(model)
        guard let user = model as? User else {
            return
        }
        
        name         = user.name ?? name
        email             = user.email ?? email
        network              = user.network ?? network
        network_id             = user.network_id
        birthstamp        = user.birthstamp ?? birthstamp
        birthday          = user.birthday ?? birthday
        device_id       = user.device_id ?? device_id
        channel_id      = user.channel_id ?? channel_id
        emailVerifiedAt    = user.emailVerifiedAt ?? emailVerifiedAt
        isNotifyReminders = user.isNotifyReminders ?? isNotifyReminders
        isNotifyNewEpisodes    = user.isNotifyNewEpisodes ?? isNotifyNewEpisodes
        isNotifyNewMerchandise    = user.isNotifyNewMerchandise ?? isNotifyNewMerchandise
        token             = user.token ?? token
    }
    
    var profile: [String: Any?] {
        return [
            "name": name,
            "birthday": birthday?.string(withFormat: Date.standardDateFormat),
        ]
    }
}

extension User {
    func isValidProfile() -> Bool {
        guard name != nil,
            birthday != nil
            else {
            return false
        }
        return true
    }
}

