//
//  VerifyCodeViewController.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/16.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class VerifyCodeViewController: BaseViewController {

    @IBOutlet weak var verifyCodeView: PinView!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    var phoneNumber: String?
    var phoneNumberFormatStr: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

       configure()
    }
    
    func configure()
    {
        lblPhoneNumber.text = "\("send_to".localized()) \(phoneNumberFormatStr) •  "
        var config:PinConfig! = PinConfig()
        config.numberOfFields     = 6
        config.dotColor           = .black
        config.lineColor          = UIColor.appLightGray
        config.spacing            = 16
        
        verifyCodeView.config = config
        verifyCodeView.setUpView()
        verifyCodeView.textFields[0].becomeFirstResponder()
    }
    @IBAction func onEdit(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
