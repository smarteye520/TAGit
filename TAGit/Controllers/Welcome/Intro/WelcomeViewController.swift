//
//  WelcomeViewController.swift
//  TAGit
//
//  Created by Macmini on 6/18/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func onTap(_ sender: Any) {
        AppManager.shared.isIntroVisited = true
        AppManager.shared.showNext()
    }
}
