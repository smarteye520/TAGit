//
//  OptionCell.swift
//  TAGit
//
//  Created by Macmini on 6/17/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit
import SnapKit

class OptionCell: BaseTableViewCell {
    override class var height: CGFloat {
        return 65
    }
    
    override class var identifier: String {
        return "OptionCell"
    }
    
    var viewOption: UIView!
    var lblOption: UILabel!
    
    func reset(with option: String?) {
        lblOption?.text = option
    }
    
    override func configure() {
        super.configure()
        
        viewOption = UIView.init(frame: self.bounds)
        viewOption.cornerRadius = 10
        viewOption.borderWidth = 1
        self.contentView.addSubview(viewOption)
        
        viewOption.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalToSuperview().offset(-15)
            $0.centerY.equalToSuperview()
        }
        
        lblOption = UILabel.init(frame: .zero)
        lblOption.font = .light(size: 14)
        viewOption.addSubview(lblOption)
        lblOption.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.centerY.equalToSuperview()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            viewOption.backgroundColor = .appBlue
            lblOption.textColor = .white
            viewOption.borderWidth = 0
        }
        else {
            viewOption.backgroundColor = .clear
            lblOption.textColor = .appGray
            viewOption.borderWidth = 1
            viewOption.borderColor = .appGray
        }
    }
}
