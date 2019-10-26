//
//  AccountSettingViewController.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/11.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit
import Intercom

class AccountSettingViewController: UIViewController {
    var settingMenu: [String] = ["setting_profile".localized(), "setting_notifications".localized(),"setting_faq".localized(),"setting_support".localized(),"setting_privacy_policy".localized(),"setting_terms_service".localized(),"setting_logout".localized()]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    
    func configure()
    {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func onFAQ() {
        Intercom.presentMessenger()
    }
    
    func onSupport() {
        Intercom.presentHelpCenter()
    }
    
    func logout() {
        let alertController = UIAlertController.init(
            title: nil,
            message: "are_you_sure".localized(),
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction.init(title: "cancel".localized(), style: UIAlertAction.Style.cancel, handler: nil))
        alertController.addAction(UIAlertAction.init(title:"yes".localized(), style: UIAlertAction.Style.default, handler: { (action) in
//            UIManager.showAuth()
            AppManager.shared.logOut()
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }

}

extension AccountSettingViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingCell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
        cell.indexPath = indexPath
        cell.tableView = tableView
        cell.controller = self
        cell.lblTitle.text = settingMenu[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingCell.height
    }
    
    
}

extension AccountSettingViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // profile
            let profileViewController = UIManager.loadViewController(storyboard: "AccountSettings", controller: "ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(profileViewController, animated: true)
            break
        case 1: // notification
            let notificationVC = UIManager.loadViewController(storyboard: "AccountSettings", controller: "NotificationSettingViewController") as! NotificationSettingViewController
            self.navigationController?.pushViewController(notificationVC, animated: true)
            break
        case 2: // FAQ
            onFAQ()
            break
        case 3: // Support
            onSupport()
            break
        case 6: // logout
            logout()
            break
        default:
            break
        }
    }
    
}

