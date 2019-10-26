//
//  DefaultButton.swift
//  TAGit
//
//  Created by Macmini on 6/17/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

@IBDesignable
class DefaultButton: UIButton {
    override var isSelected: Bool {
        didSet {
            updateStateUI()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateStateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    func configure() {
        self.cornerRadius = bounds.height / 2
        self.titleLabel?.font = .bold(size: 14)
        self.letterSpacing = 1.75
        self.borderWidth = 1
        updateStateUI()
    }
    
    func updateStateUI() {
        if isEnabled {
            self.borderColor = .appBlue
            self.titleLabel?.textColor = .appBlue
        }
        else {
            self.borderColor = .appGray
            self.titleLabel?.textColor = .appGray
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cornerRadius = bounds.height / 2        
    }
}
