//
//  ContainerViewController.swift
//  TAGit
//
//  Created by Macmini on 6/17/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class ContainerViewController: BaseViewController {
    @IBOutlet var container: UIView!
    
    var currentViewController: UIViewController? {
        didSet {
            oldValue?.removeFromParent()
            if let newController = self.currentViewController {
                self.addChild(newController)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container = container ?? self.view
    }
}
