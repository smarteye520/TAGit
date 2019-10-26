//
//  BaseTableViewCell.swift
//  MondaysAtSix
//
//  Created by Macmini on 2/18/19.
//  Copyright © 2019 Onur Erdemol. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    class var height: CGFloat {
        return 50
    }
    
    class var identifier: String {
        return "CommonTableViewCell"
    }
    
    var indexPath: IndexPath!
    var controller: UIViewController!
    var tableView: UITableView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
