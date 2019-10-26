//
//  PhoneNumberViewController.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/12.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class PhoneNumberViewController: BaseViewController {

    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblCoutryCode: UILabel!
    @IBOutlet weak var txtPhoneNumber: PhoneFormattedTextField!
    var countryCodeDropDown = DropDown()
    var countries:[CountryModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        configure()
    }
    
    func configure()
    {
        txtPhoneNumber.becomeFirstResponder()
        setupDropDown()
        txtPhoneNumber.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "### - ### - ####")
        txtPhoneNumber.textDidChangeBlock = { field in
            if let text = field?.text, text != "" {
                if self.txtPhoneNumber.phoneNumber()?.count == 10
                {
                    self.performSelector(onMainThread: #selector(self.goVerify), with: nil, waitUntilDone: false)
                }
            } else {
                print("No text")
            }
            
        }
    }

    func loadData(){
        countries = CountryModel.countries() ?? []
    }
    func setupDropDown(){
        countryCodeDropDown.anchorView = imgFlag
        countryCodeDropDown.bottomOffset = CGPoint(x: 0, y: 30)
        countryCodeDropDown.dismissMode = .onTap
        countryCodeDropDown.direction = .bottom
        countryCodeDropDown.width = 300
        let countryNames = countries.map({
            (value: CountryModel) -> String in
            return value.name ?? ""
        })
        countryCodeDropDown.dataSource = countryNames
        countryCodeDropDown.cellNib = UINib(nibName: "CountryCodeCell", bundle: nil)
        // Action triggered on selection
        countryCodeDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? CountryCodeCell else { return }
            
            // Setup your custom UI components
            cell.imgFlag.image = UIImage(named: self.countries[index].code! )
            cell.lblCountryCode.text = self.countries[index].dial_code
            cell.lblCountryName.text = self.countries[index].name
        }
        countryCodeDropDown.selectionAction = { [weak self] (index, item) in
            self?.imgFlag.image = UIImage(named: self?.countries[index].code! ?? "US")
            self?.lblCoutryCode.text = self?.countries[index].dial_code
        }
        
    }
    @objc func goVerify() {
        let verifyViewController = UIManager.loadViewController(storyboard: "AccountSettings", controller: "VerifyCodeViewController") as! VerifyCodeViewController
        verifyViewController.phoneNumberFormatStr = txtPhoneNumber.text ?? ""
        present(verifyViewController, animated: true, completion: nil)
        
    }
    @IBAction func dropDownCountries(_ sender: Any) {
        countryCodeDropDown.show()
    }
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
