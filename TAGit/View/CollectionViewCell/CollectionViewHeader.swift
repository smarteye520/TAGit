//
//  CollectionViewHeader.swift
//  TAGit
//
//  Created by Liu Jie on 2019/6/28.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewHeader: UICollectionReusableView {
    class var identifier: String {
        return "CollectionViewHeader"
    }
    var lblTitle: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.configure()
    }
    
    func configure() {
        
        lblTitle = UILabel.init(font: UIFont.medium(size: 26), color: .black, superView: self)
        lblTitle.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
        }
    }
    
}
