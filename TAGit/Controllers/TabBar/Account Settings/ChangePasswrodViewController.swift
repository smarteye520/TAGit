//
//  ChangePasswrodViewController.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/11.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class ChangePasswrodViewController: BaseViewController {

    @IBOutlet weak var txtCurPassword: UITextField!
    @IBOutlet weak var separatorCurPassword: UIView!
    @IBOutlet weak var lblCurPassword: UILabel!
    
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var separatorNewPassword: UIView!
    @IBOutlet weak var lblNewPassword: UILabel!
    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var separatorConfirmPassword: UIView!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var lblInvalideText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtCurPassword.delegate = self
        txtNewPassword.delegate = self
        txtConfirmPassword.delegate = self
        
        lblInvalideText.isHidden = true
        lblInvalideText.textColor = .appCoral
        
        separatorConfirmPassword.backgroundColor = .appLightGray
        separatorNewPassword.backgroundColor = .appLightGray
        separatorCurPassword.backgroundColor = .appLightGray
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        if sender == txtCurPassword
        {
            if sender.text?.isEmpty ?? true
            {
                lblCurPassword.isHidden = true
            }else{
                lblCurPassword.isHidden = false
            }
        }else if sender == txtNewPassword
        {
            if sender.text?.isEmpty ?? true
            {
                lblNewPassword.isHidden = true
            }else{
                lblNewPassword.isHidden = false
            }
        }else if sender == txtConfirmPassword
        {
            if sender.text?.isEmpty ?? true
            {
                lblConfirmPassword.isHidden = true
            }else{
                lblConfirmPassword.isHidden = false
            }
        }
        
    }
    @IBAction func onChangePassword(_ sender: Any) {
        if checkInput()
        {
            UIManager.showToast(message:  "password_changed".localized())
             self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func onCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
//Validator
extension ChangePasswrodViewController {
    func checkInput() -> Bool {
        guard let curPassword = txtCurPassword.text, curPassword.isValidPassword() else {
            separatorCurPassword.backgroundColor = .appCoral
            lblInvalideText.isHidden = false
            return false
        }
        
        guard let newPassword = txtNewPassword.text, newPassword.isValidPassword() else {
            separatorNewPassword.backgroundColor = .appCoral
            lblInvalideText.isHidden = false
            return false
        }
        
        guard let confirmPassword = txtConfirmPassword.text, confirmPassword.isValidPassword() else {
            separatorConfirmPassword.backgroundColor = .appCoral
            lblInvalideText.isHidden = false
            return false
        }
        guard newPassword == confirmPassword else {
            separatorNewPassword.backgroundColor = .appCoral
            separatorConfirmPassword.backgroundColor = .appCoral
            lblInvalideText.isHidden = false
            return false
        }
        return true
    }
    
    func resetInput() {
        separatorConfirmPassword.backgroundColor = .appLightGray
        separatorNewPassword.backgroundColor = .appLightGray
        separatorCurPassword.backgroundColor = .appLightGray
        lblInvalideText.isHidden = true
    }
}
extension ChangePasswrodViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        resetInput()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        resetInput()
        return true
    }
}
