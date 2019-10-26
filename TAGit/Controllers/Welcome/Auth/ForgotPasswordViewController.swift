//
//  ForgotPasswordViewController.swift
//  TAGit
//
//  Created by Macmini on 6/18/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSend: DefaultButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSend.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSend(_ sender: Any) {
        API.shared.resetPassword(email: txtEmail.text!)
            .done{ (success) in
                if (success)
                {
                    self.performSegue(withIdentifier: "sid_email_sent", sender: self)
                }
            }.catch{ (error) in
                self.showError(text: error.localizedDescription)
        }
        
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text?.replacingCharacters(in: range, with: string) else {
            return true
        }
        btnSend.isEnabled = text.isValidEmail()
        return true
    }
}

