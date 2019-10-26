//
//  UITableViewExtension.swift
//  MondaysAtSix
//
//  Created by Macmini on 3/7/19.
//  Copyright © 2019 Onur Erdemol. All rights reserved.
//

import UIKit

extension UITableView {
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
//            let scrollPoint = CGPoint(x: 0, y: self.contentSize.height - self.frame.size.height)
//            self.setContentOffset(scrollPoint, animated: true)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}
