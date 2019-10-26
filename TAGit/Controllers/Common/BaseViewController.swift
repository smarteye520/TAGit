//
//  BaseViewController.swift
//  ActionIWS
//
//  Created by Macmini on 1/25/19.
//  Copyright © 2019 Majestyk Apps. All rights reserved.
//

import UIKit
import Hero

class BaseViewController: UIViewController {
    var swipeEnabled: Bool! = true
    var panGesture: UIPanGestureRecognizer!
// Navigation Bar
    @IBInspectable var showTopBar: Bool = true
    
// UnWind Segue
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }

// Controller Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extendedLayoutIncludesOpaqueBars = false
        self.edgesForExtendedLayout = []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBar()
        if let navController = self.navigationController {
            navController.interactivePopGestureRecognizer?.isEnabled = false
            if swipeEnabled, navController.hero.isEnabled == false {
                navController.hero.isEnabled = true
            }
        }
        if swipeEnabled {
            self.configurePan()
        }
    }
    
    func updateNavigationBar() {
        if let navController = self.navigationController{
            navController.navigationBar.prefersLargeTitles = false
            navController.setNavigationBarHidden(!showTopBar, animated: false)
            if navController.navigationBar.topItem?.title == nil {
                navController.navigationBar.topItem?.title = self.title
            }
        }
    }
    
    func configurePan() {
        guard self.panGesture == nil else {
            return
        }
        
        guard self.isRootController() == false else {
            return
        }
        
        self.hero.isEnabled = true
        panGesture = UIPanGestureRecognizer(target: self,
                                            action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
        panGesture.delegate = self
        view.isUserInteractionEnabled = true
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: nil)
        let progress = translation.x / 1.3 / view.bounds.width
        
        switch panGesture.state {
        case .began:
            
            self.hero.dismissViewController()
        //            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(progress)
        default:
            if progress + panGesture.velocity(in: nil).x / view.bounds.width > 0.8 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
}
extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        if let touchView = touch.view {
//            if touchView is CommonSlider || touchView.superview is CommonSlider {
//                return false
//            }
//        }
        return true
    }
}
