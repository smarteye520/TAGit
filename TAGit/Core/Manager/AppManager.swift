
//
//  AppManager.swift
//  TAGit
//
//  Created by Macmini on 1/25/19.
//  Copyright © 2019 Majestyk Apps. All rights reserved.
//

import UIKit
import ObjectMapper

class AppManager: NSObject {
    static let shared = AppManager()
    
    var isGuest: Bool = false
    
    var isLoggedIn: Bool{
        guard let user = currentUser else {
            return false
        }
        
        guard user.id != nil, let token = user.token, token.accessToken != nil else {
            return false
        }
        return true
    }
    var isProfileCompleted: Bool {
        get {
            return KeychainManager.getBool(for: "profileCreated")
        }
        set {
            KeychainManager.setBool(value: newValue, for: "profileCreated")
        }
    }
    var isIntroVisited: Bool = false
    var isSplashShowed: Bool = false
    
    override init() {
        super.init()
        loadUser()
    }
    
    // Current User
    var currentUser : User?
    var loggedIn: Bool{
        guard let user = currentUser else {
            return false
        }
        
        guard user.id != nil, let token = user.token, token.accessToken != nil else {
            return false
        }
        return true
    }
    
    func loadUser() {
        if let json = KeychainManager.getString(for: "current_user"), json.count > 0 {
            let mapper = Mapper<User>()
            currentUser = mapper.map(JSONString: json)
        }
        else {
            currentUser = User()
        }
    }
    
    func saveUser(){
        KeychainManager.setString(value: currentUser?.toJSONString() ?? "", for: "current_user")
    }
    
    func saveCurrentUser(user: User) {
        if let currentUser = self.currentUser {
            currentUser.attach(user)
        }
        else {
            self.currentUser = user
        }
        saveUser()
    }
    
    func logOut() {
        self.currentUser = nil
        self.saveUser()
        isProfileCompleted = false
        UIManager.showAuth()
    }
}

extension AppManager {
    func showNext() {
//        UIManager.showMain()
//       return
        
        if isLoggedIn {
            if isProfileCompleted {
                if isIntroVisited {
                    UIManager.showMain()
                }
                else {
                    UIManager.showIntro()
                }
            }
            else {
                UIManager.showProfileSetup()
            }
        }
        else {
            UIManager.showAuth()
        }
    }
}
