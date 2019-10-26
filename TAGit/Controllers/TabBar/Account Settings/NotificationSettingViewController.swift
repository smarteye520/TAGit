//
//  NotificationSettingViewController.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/12.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class NotificationSettingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
