//
//  UIManager.swift
//  TAGit
//
//  Created by Macmini on 2/11/19.
//  Copyright © 2019 Onur Erdemol. All rights reserved.
//

import UIKit
//import Hero
import Toast
import SVProgressHUD

class UIManager {
    static let shared = UIManager()
    var tabBarController: TabBarController? {
        guard let controller = UIApplication.shared.keyWindow?.rootViewController, controller is TabBarController else {
            return nil
        }
        return controller as? TabBarController
    }
    
    func initTheme() {
        //Toast Style
        let style: CSToastStyle = CSToastStyle.init(defaultStyle: ())
        style.messageColor = UIColor.white
        style.backgroundColor = UIColor.appBlue
        style.messageFont = UIFont.regular(size: 17)
        style.cornerRadius = 0
        style.activitySize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        CSToastManager.setSharedStyle(style)
        CSToastManager.setTapToDismissEnabled(true)
        CSToastManager.setQueueEnabled(true)
        
        
        //SVProgressHUD
        SVProgressHUD.setGraceTimeInterval(0.5)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.setForegroundColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        SVProgressHUD.setBackgroundColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.5))
        
        
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = UIColor.appBlack
        appearance.barTintColor = UIColor.white
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appBlack , NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = UIColor.appBlue
        tabBarAppearance.barTintColor = UIColor.white
        
        let tabBarItemAppearance = UITabBarItem.appearance()
        tabBarItemAppearance.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.regular(size: 11)], for: .normal)
        tabBarItemAppearance.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.regular(size: 12)], for: .selected)

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.appDarkGray
    }
    
    //Toast
    static func showToast(message: String, duration: TimeInterval = 3.0, position: String = CSToastPositionBottom, title: String? = nil, image: UIImage? = nil) {
        if let window = UIApplication.shared.keyWindow {
            window.makeToast(message, duration: duration, position: position, title: title, image: nil, style: nil, completion: nil)
        }
    }
}


//App View
extension UIManager {
    //Show Tab Bar Controller
    static func showMain(animated: Bool = true) {
        let tabBarController = TabBarController()
        self.setRootViewController(controller: tabBarController, animated: animated)
    }
    
    //Show SignUp/Login View Controller
    static func showAuth(animated: Bool = true) {
        guard let controller = loadViewController(storyboard: "Auth", controller: "sid_auth") as? BaseViewController else {
            return
        }
        let navigationViewController = UINavigationController.init(rootViewController: controller)
        self.setRootViewController(controller: navigationViewController, animated: animated)
    }
    
    //Show Profile Setup
    static func showProfileSetup(animated: Bool = true) {
        guard let controller = loadViewController(storyboard: "ProfileSetup") as? BaseViewController else {
            return
        }
        let navigationViewController = UINavigationController.init(rootViewController: controller)
        self.setRootViewController(controller: navigationViewController, animated: animated)
    }
    
    static func showTaggingSetup(animated: Bool = true) {
        guard let controller = loadViewController(storyboard: "ProfileSetup", controller:"TaggingOptionsViewController") as? TaggingOptionsViewController else {
            return
        }
        let navigationViewController = UINavigationController.init(rootViewController: controller)
        self.setRootViewController(controller: navigationViewController, animated: animated)
    }
    
    //Show Intro
    static func showIntro(animated: Bool = true) {
        guard let controller = loadViewController(storyboard: "Intro") as? BaseViewController else {
            return
        }
        let navigationViewController = UINavigationController.init(rootViewController: controller)
        self.setRootViewController(controller: navigationViewController, animated: animated)
    }
}

//Primary
extension UIManager {
    static func loadViewController(storyboard name: String, controller identifier: String? = nil) -> UIViewController? {
        guard let identifier = identifier else {
            return UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()
        }
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    static func bottomPadding() -> CGFloat {
        guard #available(iOS 11.0, *), let window = UIApplication.shared.keyWindow else {
                return 0
        }
        return window.safeAreaInsets.bottom
    }
/*
    //present view controller with Hero animation
    static func presentViewController(controller: UIViewController, animated: Bool = true, animationType: HeroDefaultAnimationType = .selectBy(presenting: .cover(direction: .left), dismissing: .uncover(direction: .right)), viewController: UIViewController? = nil) {
        
        if let viewController = viewController {
            controller.hero.isEnabled = true
            controller.hero.modalAnimationType = animationType
            viewController.present(controller, animated: animated, completion: nil)
            return
        }
        
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            return
        }
        DispatchQueue.main.async {
            controller.hero.isEnabled = true
            controller.hero.modalAnimationType = animationType
            rootViewController.present(controller, animated: animated, completion: nil)
        }
    }
    
    static func presentFromLeft(controller: UIViewController, animated: Bool = true, viewController: UIViewController? = nil) {
        let animationType: HeroDefaultAnimationType = .selectBy(presenting: .push(direction: .right), dismissing: .pull(direction: .left))
        self.presentViewController(controller: controller, animated: animated, animationType: animationType, viewController: viewController)
    }
    
    static func presentFromRight(controller: UIViewController, animated: Bool = true, viewController: UIViewController? = nil) {
        let animationType: HeroDefaultAnimationType = .selectBy(presenting: .push(direction: .left), dismissing: .pull(direction: .right))
        self.presentViewController(controller: controller, animated: animated, animationType: animationType, viewController: viewController)
    }
    
    static func presentFromBottom(controller: UIViewController, animated: Bool = true, viewController: UIViewController? = nil) {
        let animationType: HeroDefaultAnimationType = .selectBy(presenting: .cover(direction: .up), dismissing: .uncover(direction: .down))
        self.presentViewController(controller: controller, animated: animated, animationType: animationType, viewController: viewController)
    }
 */
    //change root view controller
    static func setRootViewController(controller: UIViewController, animated: Bool = false) {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow {
                guard let rootViewController = window.rootViewController else {
                    return
                }
                
                controller.view.frame = rootViewController.view.frame
                controller.view.layoutIfNeeded()
                
                if animated {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        window.rootViewController = controller
                    }, completion: nil)
                }
                else {
                    window.rootViewController = controller
                }
            }
            else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
                appDelegate.window?.backgroundColor = UIColor.white
                appDelegate.window?.rootViewController = controller
                appDelegate.window?.makeKeyAndVisible()
            }
        }
    }
}
