//
//  TaggingCollectionViewCell.swift
//  TAGit
//
//  Created by Macmini on 6/17/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class TaggingCollectionViewCell: BaseCollectionViewCell {
    static var identifier: String = "Tagging_Option_Cell"
    static var height: CGFloat {
        return 50
    }

    var viewOption: UIView!
    var lblOption: UILabel!
    
    override var isSelected: Bool {
        didSet {
            updateUI()
        }
    }
    
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
            $0.edges.equalToSuperview()
        }
        
        lblOption = UILabel.init(frame: .zero)
        viewOption.addSubview(lblOption)
        lblOption.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.centerY.equalToSuperview()
        }
        
        updateUI()
    }
    
    func updateUI() {
        if isSelected {
            viewOption.backgroundColor = .appBlue
            lblOption.textColor = .white
            lblOption.font = .regular(size: 16)
            viewOption.borderWidth = 0
        }
        else {
            viewOption.backgroundColor = .clear
            lblOption.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            lblOption.font = .light(size: 16)
            viewOption.borderWidth = 1
            viewOption.borderColor = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
        }
    }
}
