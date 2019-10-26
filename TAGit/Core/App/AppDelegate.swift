//
//  AppDelegate.swift
//  TAGit
//  
//  Created by Joseph Hyun Lee on 4/25/19
//  Copyright © 2019 Majestyk. All Rights Reserved.
//

import FBSDKCoreKit
import UIKit
import GoogleSignIn
import IQKeyboardManagerSwift
import Intercom

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        loadFrameworks()
        setupThirdPartyAuthentication(application: application, launchOptions: launchOptions)
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses.append(UIStackView.self)
        
        AppManager.shared.showNext()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

//Load framework
extension AppDelegate {
    func loadFrameworks() {
        //UI
        UIManager.shared.initTheme()
        //Intercom
        Intercom.setApiKey(ThirdPartyAPI.Intercom.secretKey, forAppId: ThirdPartyAPI.Intercom.appId)
        Intercom.registerUnidentifiedUser()
    }
}


//3rd party authentication
extension AppDelegate {
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let facebookHandled = FBSDKApplicationDelegate.sharedInstance()?.application(app, open:url, options:options)
        let googleHandled = GIDSignIn.sharedInstance().handle(
            url as URL?,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        return (facebookHandled ?? true || googleHandled)
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        let facebookHandled = FBSDKApplicationDelegate.sharedInstance()?.application(
            application, open: url, sourceApplication: sourceApplication, annotation: annotation
        )
        
        let googleHandled = GIDSignIn.sharedInstance().handle(
            url, sourceApplication: sourceApplication, annotation: annotation
        )
        
        return googleHandled || (facebookHandled ?? true)
    }
    
    func setupThirdPartyAuthentication(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // Google authentication
        // TODO: Change the bundle identifier in info.plist when using different client ID
        let googleClientID = "1027369891600-tt5ududh630su1tooek36k6l7qjpbl2a.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.clientID = googleClientID
        GIDSignIn.sharedInstance()?.delegate = self
        
        // Facebook authentication
        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
        NotificationCenter.default.addObserver(forName: NSNotification.Name.FBSDKAccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            if notification.userInfo?[FBSDKAccessTokenDidChangeUserIDKey] != nil {
                FBSDKProfile.loadCurrentProfile(completion: { (profile, error) in
                    if let error = error {
                        NotificationCenter.default.post(name: .FacebookSignInError, object: nil, userInfo: ["error": error.localizedDescription])
                        return
                    }
                    if let profile = profile {
                        NotificationCenter.default.post(name: .FacebookSignInSuccess, object: nil, userInfo: ["profile": profile])
                    }
                })
            } else {
                NotificationCenter.default.post(name: .FacebookSignInError, object: nil, userInfo: ["error": "could not login"])
            }
        }
    }
}

extension AppDelegate: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            // DEBUG: error
            NotificationCenter.default.post(name: .GoogleSignInError,
                                            object: nil,
                                            userInfo: ["status": "Could not log in user.", "error": error.localizedDescription])
        } else {
            /*
            let userID = user.userID
            let idToken = user.authentication.idToken
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            */
            // DEBUG: user
            NotificationCenter.default.post(name: .GoogleSignInSuccess,
                                            object: nil,
                                            userInfo: ["status": "Successfully logged in user.", "user": user])
        }
    }

}

extension Notification.Name {
    static let GoogleSignInSuccess = Notification.Name(rawValue: "GoogleSignInSuccessNotification")
    static let GoogleSignInError = Notification.Name(rawValue: "GoogleSignInErrorNotification")
    static let GoogleSignOut = Notification.Name(rawValue: "GoogleSignOutNotification")
}

extension Notification.Name {
    static let FacebookSignInSuccess = Notification.Name(rawValue: "FacebookSignInSuccessNotification")
    static let FacebookSignInError = Notification.Name(rawValue: "FacebookSignInErrorNotification")
    static let FacebookSignOut = Notification.Name(rawValue: "FacebookSignOutNotification")
}
