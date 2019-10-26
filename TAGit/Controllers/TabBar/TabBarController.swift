//
//  TabBarController.swift
//  MondaysAtSix
//
//  Created by Onur Erdemol
//  Copyright © 2019 Onur Erdemol. All rights reserved.
//

import UIKit
extension UITabBar {    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = window.safeAreaInsets.bottom + Constant.UI.TAP_BAR_HEIGHT
        return sizeThatFits
    }
}

class TabBarController: UITabBarController {
    
    //MARK:- Methods
    //MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildControllers()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var newFrame = tabBar.frame
        newFrame.size.height = Constant.UI.TAP_BAR_HEIGHT + (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0)
        newFrame.origin.y = view.frame.size.height - newFrame.size.height
        
        tabBar.frame = newFrame
    }
    
    func buildControllers() {
        let controllerAssets: [(icon: String, title: String, storyboardId: String)] = [
            (icon: "tabbar_icon_home", title: "Home", storyboardId: "Home"),
            (icon: "tabbar_icon_search", title: "Search", storyboardId: "Search"),
            (icon: "tabbar_icon_favorite", title: "Favorites", storyboardId: "Favorites"),
            (icon: "tabbar_icon_notifications", title: "Notifications", storyboardId: "Notifications"),
            (icon: "tabbar_icon_account", title: "Account", storyboardId: "AccountSettings")
        ]
        
        var childControllers: [UIViewController] = []
        for i in 0..<controllerAssets.count {
            let asset = controllerAssets[i]
            if let navigationController = UIManager.loadViewController(storyboard: asset.storyboardId) {
                let tabBarItem = UITabBarItem(title: asset.title, image: UIImage(named: asset.icon), tag: i)
                navigationController.tabBarItem = tabBarItem
                childControllers.append(navigationController)
            }
        }
        self.viewControllers = childControllers
    }
}

