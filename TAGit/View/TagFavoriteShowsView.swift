//
//  TagFavoriteShowsView.swift
//  TAGit
//  
//  Created by Joseph Hyun Lee on 5/3/19
//  Copyright © 2019 Joseph. All Rights Reserved.
//  

import UIKit

protocol TagFavoriteShowsViewDelegate: AnyObject {
    func tagFavoriteShowsView(_ tagFavoriteShowsView: TagFavoriteShowsView,  didPressTagFavoriteShowsButton favoriteShowsButton: UIButton)
    
}

class TagFavoriteShowsView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var tagFavoriteShowsButton: UIButton!
    weak var delegate: TagFavoriteShowsViewDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBAction func tagFavoriteShowsButtonPressed(_ sender: Any) {
        self.delegate?.tagFavoriteShowsView(self, didPressTagFavoriteShowsButton: tagFavoriteShowsButton)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsLayout()
        self.layoutIfNeeded()
        contentView = (Bundle.main.loadNibNamed("TagFavoriteShowsView", owner: self, options: nil)!.first as! UIView)
        contentView.frame = self.bounds
        self.addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
