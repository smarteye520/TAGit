//
//  SettingCell.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/11.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class SettingCell: BaseTableViewCell {
    override class var height: CGFloat {
        return 50
    }
    
    override class var identifier: String {
        return "SettingCell"
    }
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
