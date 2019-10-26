//
//  Constant.swift
//  TAGit
//
//  Created by Macmini on 1/25/19.
//  Copyright © 2019 Majestyk Apps. All rights reserved.
//

import UIKit

struct Constant {
    struct UI {
        static let TAP_BAR_HEIGHT: CGFloat = 60
        static let COMMON_BUTTON_HEIGHT = 50
        static var SCREEN_WIDTH: CGFloat {
            return UIScreen.main.bounds.width
        }
    }
}
struct ThirdPartyAPI {
    struct Intercom {
        static let appId = "npn6y6v9"
        static let secretKey = "ios_sdk-8b004dfd1e82643b95ae30677f6183435b1e95c3"
    }
}
extension Notification.Name {
    static let forceLogout = Notification.Name("forceLogout")
}

