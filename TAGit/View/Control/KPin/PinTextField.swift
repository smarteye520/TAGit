//
//  OTPTextField.swift
//
//  Created by Krishna on 24/04/17.
//  Copyright © 2017 Konstant. All rights reserved.
//

import UIKit

protocol OTPDelegate {
    func OTPTextFieldDidPressBackspace(textfield: PinTextField)
}

class PinTextField: UITextField {

    var delegateOTP:OTPDelegate!
    
    override func deleteBackward() {
        super.deleteBackward()
        
        if delegateOTP != nil {
            delegateOTP.OTPTextFieldDidPressBackspace(textfield: self)
        }
    }
    
}
