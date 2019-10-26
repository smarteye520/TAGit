//
//  SignViewController.swift
//  TAGit
//
//  Created by Macmini on 6/17/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class SignInViewController: BaseViewController {
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var separatorEmail: UIView!
    @IBOutlet weak var lblEmailDescription: UILabel!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var separatorPassword: UIView!
    @IBOutlet weak var lblPasswordDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtEmail.delegate = self
        txtPassword.delegate = self
    }
    
    @IBAction func onLogin(_ sender: Any) {
        if checkInput() {
            //API call

            API.shared.signIn(email: txtEmail.text!, password: txtPassword.text!)
                .done { (user) in
                    AppManager.shared.saveCurrentUser(user: user)
                    self.loginSuccess()
                }
                .catch { (error) in
                    self.showError(text: error.localizedDescription)
            }
        }
    }
    
    func loginSuccess() {
        AppManager.shared.showNext()
    }
}

//Validator
extension SignInViewController {
    func checkInput() -> Bool {
        guard let email = txtEmail.text, email.isValidEmail() else {
            lblEmailDescription.text = "invalid_email".localized()
            lblEmailDescription.textColor = .appCoral
            separatorEmail.backgroundColor = .appCoral
            return false
        }
        
        guard let password = txtPassword.text, password.isValidPassword() else {
            lblPasswordDescription.text = "invalid_password".localized()
            lblPasswordDescription.textColor = .appCoral
            separatorPassword.backgroundColor = .appCoral
            return false
        }
        return true
    }

    func resetInput() {
        lblEmailDescription.text = nil
        lblPasswordDescription.textColor = .appLineGray
        separatorEmail.backgroundColor = .appLineGray
        separatorPassword.backgroundColor = .appLineGray
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        resetInput()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        resetInput()
        return true
    }
}

