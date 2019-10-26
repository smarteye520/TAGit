//
//  ProfileViewController.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/11.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var lblBirthDay: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    
    var genderOptions:[String]! = ["female".localized(), "male".localized(), "non_binary".localized()]
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onBirthDay(_ sender: Any) {
        RPicker.selectDate(title: "select_birthday".localized(), didSelectDate: { (selectedDate) in
            // TODO: Your implementation for date
            self.lblBirthDay.text = selectedDate.dateString()
        })
    }
    
    @IBAction func onGender(_ sender: Any) {
        RPicker.selectOption(title: "select_gender".localized(), hideCancel: false, dataArray: genderOptions, selectedIndex: 0) { (selctedText, atIndex) in
            self.lblGender.text = selctedText
        }
    }
    
    @IBAction func onSave(_ sender: Any) {
        UIManager.showToast(message: "changes_saved".localized())
        self.navigationController?.popViewController(animated: true)
    }
}
