//
//  RelatedShowCell.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/2.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit
import Kingfisher

class RelatedShowCell: BaseCollectionViewCell {
    class var identifier: String {
        return "RelatedShowCell"
    }
    
    var imgShow: UIImageView!
    var btnCheck: UIButton!
    var coverView: UIView!
    var btnTappable: UIButton!
    
    var isSelectable: Bool = false
    
    weak var show: Show?
    
    func reset(with show: Show?) {
        self.show = show
        imgShow.kf.indicatorType = .activity
        if let imgUrl = show?.image {
            imgShow.kf.setImage(with: URL(string: imgUrl)) { [weak self] (image, error, type, url) in
                self?.layoutIfNeeded()
            }
        }
        if(isSelectable)
        {
            self.coverView.isHidden = false
            self.btnCheck.isHidden = false
        }else{
            self.coverView.isHidden = true
            self.btnCheck.isHidden = true
            self.btnCheck.isSelected = false
        }
    }
    
    override func configure() {
        super.configure()
        
        //Image
        imgShow = UIImageView.init(contentMode: .scaleAspectFill, superView: self.contentView)
        imgShow.translatesAutoresizingMaskIntoConstraints = false
        imgShow.clipsToBounds = true
        imgShow.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.left.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        coverView = UIView(frame: .zero)
        self.contentView.addSubview(coverView)
        coverView.snp.makeConstraints {
            $0.bottom.left.right.top.equalToSuperview()
        }
        coverView.backgroundColor = UIColor.init(white: 1.0, alpha: 0.4)
        coverView.isHidden = true
        
        btnTappable = UIButton.init(image: nil, action: #selector(onCheck(_:)), target: self, superView: self.coverView)
        btnTappable.snp.makeConstraints {
            $0.bottom.left.right.top.equalToSuperview()
        }
        
        btnCheck = UIButton.init(image: UIImage(named: "icon_mark_unchecked"), action: #selector(onCheck(_:)), target: self, superView: self.contentView)
        btnCheck.setImage(UIImage(named: "icon_mark_checked"), for: .selected)
        
        btnCheck.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.top.equalToSuperview().offset(4)
            $0.right.equalToSuperview().offset(-4)
        }
        
        btnCheck.isHidden = true
    }
    @objc
    func onCheck(_ sender: Any) {
        self.btnCheck.isSelected = !self.btnCheck.isSelected
    }
}
