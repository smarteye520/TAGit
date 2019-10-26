//
//  EpisodeCell.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/11.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import Foundation
import Kingfisher
class EpisodeCell: BaseCollectionViewCell {
    class var identifier: String {
        return "EpisodeCell"
    }
    
    var imgShow: UIImageView!
    var bottomArrow: UIImageView!
    var coverView: UIView!
    var bottomView: UIView!
    var lblTitle: UILabel!
    
    var selectedItem: Bool = false
    
    weak var show: TVShow?
    
    func reset(with show: TVShow?) {
        self.show = show
        imgShow.kf.indicatorType = .activity
        if let imgUrl = show?.image {
            imgShow.kf.setImage(with: URL(string: imgUrl)) { [weak self] (image, error, type, url) in
                self?.layoutIfNeeded()
            }
        }
        if(selectedItem)
        {
            self.coverView.isHidden = true
            bottomArrow.isHidden = false
        }else{
            self.coverView.isHidden = false
            bottomArrow.isHidden = true
        }
    }
    
    override func configure() {
        super.configure()
        imgShow = UIImageView.init(contentMode: .scaleAspectFill, superView: self.contentView)
        imgShow.translatesAutoresizingMaskIntoConstraints = false
        imgShow.clipsToBounds = true
        imgShow.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.left.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        bottomView = UIView(frame: .zero)
        self.contentView.addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(30)
        }
        bottomView.backgroundColor = UIColor.black
        lblTitle = UILabel.init(font: UIFont.light(size: 15), color: UIColor.white, superView: self.bottomView)
        lblTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        bottomArrow = UIImageView.init(contentMode: .scaleAspectFit, superView: self.contentView)
        bottomArrow.image = UIImage(named: "icon_bottom_fill_arrow")
        bottomArrow.translatesAutoresizingMaskIntoConstraints = false
        bottomArrow.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerX.equalTo(bottomView.snp.centerX)
            $0.top.equalTo(bottomView.snp.bottom).offset(-6)
        }
        bottomArrow.isHidden = true
        coverView = UIView(frame: .zero)
        self.contentView.addSubview(coverView)
        coverView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalTo(bottomView.snp.bottom)
        }
        coverView.backgroundColor = UIColor.init(r: 0, g: 0, b: 0, alpha: 0.4)
        coverView.isHidden = false
    }
}
