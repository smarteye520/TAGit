//
//  UIViewControllerExtension.swift
//  TAGit
//
//  Created by Macmini on 6/14/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

extension UIViewController {
    func isRootController() -> Bool {
        let vc = self.navigationController?.viewControllers.first
        if self == vc {
            return true
        }
        return false
    }
    
    func showError(text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessage(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
