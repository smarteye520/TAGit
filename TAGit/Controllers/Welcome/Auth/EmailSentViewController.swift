//
//  EmailSentViewController.swift
//  TAGit
//
//  Created by Macmini on 6/18/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class EmailSentViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackToLogin(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func onResendPasswordResetLink(_ sender: Any) {
        
    }    
}
