//
//  BaseCollectionViewCell.swift
//  TAGit
//
//  Created by Macmini on 6/17/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Objects
    //MARK:-
    
    var indexPath: IndexPath!
    var controller: UIViewController!
    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configure()
    }
    
    func configure() {
        
    }
}


