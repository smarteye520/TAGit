//
//  SignUpViewController.swift
//  TAGit
//
//  Created by Macmini on 6/17/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {
    @IBOutlet weak var txtFullname: UITextField!
    @IBOutlet weak var lblFullnameDescription: UILabel!
    @IBOutlet weak var separatorFullname: UIView!
    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblEmailDescription: UILabel!
    @IBOutlet weak var separatorEmail: UIView!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var separatorPassword: UIView!
    @IBOutlet weak var lblPasswordDescription: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.delegate = self
        txtFullname.delegate = self
        txtPassword.delegate = self
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        if checkInput() {
            //API call

            API.shared.signUp(email: txtEmail.text!, password: txtPassword.text!, fullName: txtFullname.text!)
                .done{ (user) in
                    AppManager.shared.saveCurrentUser(user: user)
                    self.signUpSuccess()
                }
                .catch { (error) in
                   self.showError(text: error.localizedDescription)
            }
        }
    }
    
    func signUpSuccess() {
        AppManager.shared.showNext()
    }
}

//Validator
extension SignUpViewController {
    func checkInput() -> Bool {
        guard let fullname = txtFullname.text, fullname.isValidName() else {
            lblFullnameDescription.text = "invalid_fullname".localized()
            lblFullnameDescription.textColor = .appCoral
            separatorFullname.backgroundColor = .appCoral
            return false
        }
        
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
        lblFullnameDescription.text = nil
        lblPasswordDescription.textColor = .appLineGray        
        separatorFullname.backgroundColor = .appLineGray
        separatorEmail.backgroundColor = .appLineGray
        separatorPassword.backgroundColor = .appLineGray
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        resetInput()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        resetInput()
        return true
    }
}

