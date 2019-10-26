//
//  FavoritesParentViewController.swift
//  TAGit
//  
//  Created by Joseph Hyun Lee on 5/1/19
//  Copyright © 2019 Joseph. All Rights Reserved.
//  

import UIKit
import XLPagerTabStrip

extension Notification.Name {
    static let FavoritesViewControllerCancelButtonPressed = Notification.Name(rawValue: "FavoritesViewControllerCancelButtonPressed")
    static let FavoritesViewControllerSelectButtonPressed = Notification.Name(rawValue: "FavoritesViewControllerFavoriteButtonPressed")
}

class FavoritesParentViewController: ButtonBarPagerTabStripViewController {
  
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var toastView: UIView!
    @IBOutlet weak var btnToast: UIButton!
    @IBOutlet weak var toastViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = UIColor.appBlue
        settings.style.selectedBarHeight = 2.0
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.appGray
            oldCell?.label.font = UIFont.regular(size: 17)
            newCell?.label.textColor = UIColor.appBlue
            newCell?.label.font = UIFont.medium(size: 17)
        }
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBar()
    }
    func updateNavigationBar() {
        if let navController = self.navigationController{
            navController.navigationBar.prefersLargeTitles = false
            navController.setNavigationBarHidden(true, animated: false)
            if navController.navigationBar.topItem?.title == nil {
                navController.navigationBar.topItem?.title = self.title
            }
        }
    }
    
    private func setup() {
        // Update indicatorView's width
       
        btnSelect.setTitle("cancel".localized(), for: .selected)
        btnSelect.setTitle("select".localized(), for: .normal)
        btnSelect.addTarget(self, action: #selector(selectButtonPressed(_:)), for: .touchUpInside)
    }

    @objc func selectButtonPressed(_ sender: Any?) {
        if self.btnSelect.isSelected
        {
            NotificationCenter.default.post(name: .FavoritesViewControllerCancelButtonPressed, object: self, userInfo: nil)
            //enable swipe page
            self.containerView.isScrollEnabled = true
            self.buttonBarView.isUserInteractionEnabled = true
            UIView.animate(withDuration: 1.0, animations: { [weak self] in
                self?.toastViewBottomConstraint.constant = -50
            })
        }else{
            NotificationCenter.default.post(name: .FavoritesViewControllerSelectButtonPressed, object: self, userInfo: nil)
            //enable swipe page
            self.containerView.isScrollEnabled = false
            self.buttonBarView.isUserInteractionEnabled = false
            UIView.animate(withDuration: 1.0, animations: { [weak self] in
                self?.toastViewBottomConstraint.constant = 0
                })
        }
        self.btnSelect.isSelected = !self.btnSelect.isSelected
    }
    
    @IBAction func onBtnToast(_ sender: Any) {
        var message = "alert_confirm_remove_shows".localized()
        if(self.currentIndex == 0)
        {
            message = "alert_confirm_remove_items".localized()
        }
        let alertController = UIAlertController.init(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction.init(title: "cancel".localized(), style: UIAlertAction.Style.cancel, handler: nil))
        alertController.addAction(UIAlertAction.init(title:"remove".localized(), style: UIAlertAction.Style.default, handler: { (action) in
            
            var toast = "toast_show_removed".localized()
            if(self.currentIndex == 0)
            {
                toast = "toast_item_removed".localized()
            }
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {[weak self] in
                self?.toastViewBottomConstraint.constant = -50
                }, completion:nil)
            UIManager.showToast(message: toast)
            self.selectButtonPressed(nil)
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let clothTab = UIManager.loadViewController(storyboard: "Favorites", controller: "FavoriteClothesViewController") as! FavoriteClothesViewController
        let tvShowTab = UIManager.loadViewController(storyboard: "Favorites", controller: "FavoriteTVShowsViewController") as! FavoriteTVShowsViewController
        return [clothTab, tvShowTab]
    }

}

