//
//  ProgressHud.swift
//  ActionIWS
//
//  Created by OSX on 7/3/19.
//  Copyright © 2019 Majestyk Apps. All rights reserved.
//

import Foundation
import SVProgressHUD

class ProgressHUD {
    static func show() {        
        SVProgressHUD.show()
    }
    
    static func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    static func configure() {
        SVProgressHUD.setGraceTimeInterval(0.5)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
    }
}
