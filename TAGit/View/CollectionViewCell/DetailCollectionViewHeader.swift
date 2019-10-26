//
//  File.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/1.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit
import Kingfisher

class DetailCollectionViewHeader: UICollectionReusableView {
    class var identifier: String {
        return "DetailCollectionViewHeader"
    }
    var lblTitle: UILabel!
    var lblDescription: UILabel!
    var btnShop: DefaultButton!
    var viewContainer: UIView!
    var lblWhere: UILabel!
    var lblGTitle: UILabel!
    var imgShow: UIImageView!
    var btnLike: UIButton!
    var show: Show? {
        didSet {
            guard let item = self.show else {
                return
            }
            lblGTitle.text = item.gtitle
            lblDescription.text = item.gdescription
            lblTitle.text = "More from \(item.category ?? "")"
            lblWhere.text = item.gwhere
            imgShow.kf.indicatorType = .activity
            if let imgUrl = show?.image {
                imgShow.kf.setImage(with: URL(string: imgUrl)) { [weak self] (image, error, type, url) in
                    self?.layoutIfNeeded()
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.configure()
    }
    
    func configure() {
        
        viewContainer = UIView()
        self.addSubview(viewContainer)
        viewContainer.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        lblTitle = UILabel.init(font: UIFont.medium(size: 22), color: .black, superView: viewContainer)
        lblTitle.textAlignment = .center
        lblTitle.text = "More from"
        lblTitle.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(12)
        }
        
        btnShop = DefaultButton()
        btnShop.addTarget(self, action: #selector(onTagFavorite(_:)), for: .touchUpInside)
        btnShop.titleLabel?.font = UIFont.bold(size: 14)
        btnShop.setTitle("shop".localized(), for: .normal)
        btnShop.setTitleColor(UIColor.appBlue, for: .normal)
        btnShop.setImage(UIImage(named: "icon_shop_pin_filled"), for: .normal)
        viewContainer.addSubview(btnShop)
        btnShop.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(lblTitle.snp.top).offset(-20)
            $0.width.equalTo(160)
            $0.height.equalTo(50)
        }
        btnShop.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        lblDescription = UILabel.init(font: UIFont.regular(size: 14), color: UIColor.black, superView: viewContainer)
        lblDescription.numberOfLines = 0
        lblDescription.text = ""
        lblDescription.snp.makeConstraints {
            $0.left.equalTo(lblTitle.snp.left)
            $0.right.equalToSuperview().offset(-60)
            $0.bottom.equalTo(btnShop.snp.top).offset(-40)
        }
        lblWhere = UILabel.init(font: UIFont.light(size: 14), color: UIColor.appGray, superView: viewContainer)
        lblWhere.textAlignment = .left
        lblWhere.text = ""
        lblWhere.snp.makeConstraints {
            $0.bottom.equalTo(lblDescription.snp.top).offset(-2)
            $0.left.equalToSuperview().offset(12)
        }
        lblGTitle = UILabel.init(font: UIFont.medium(size: 20), color: .black, superView: viewContainer)
        lblGTitle.textAlignment = .left
        lblGTitle.text = ""
        lblGTitle.snp.makeConstraints {
            $0.bottom.equalTo(lblWhere.snp.top)
            $0.left.equalTo(lblTitle.snp.left)
            $0.right.equalToSuperview().offset(50)
        }
        //Image
        imgShow = UIImageView.init(contentMode: .scaleAspectFill, superView: viewContainer)
        imgShow.translatesAutoresizingMaskIntoConstraints = false
        imgShow.clipsToBounds = true
        imgShow.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.left.top.equalToSuperview()
            $0.bottom.equalTo(lblGTitle.snp.top).offset(-8)
        }
        
        btnLike = UIButton.init(image: UIImage(named: "icon_heart_black"), selectedImage: UIImage(named: "icon_heart_blue_bordered"), action: #selector(onLike(_:)), target: self, superView: viewContainer)
        btnLike.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalTo(lblGTitle.snp.centerY)
            $0.right.equalToSuperview().offset(-20)
        }
        
        
    }
    @objc
    func onTagFavorite(_ sender: Any) {
        print("a");
    }
    
    @objc
    func onLike(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    func getDescriptionHeight(text: String) -> CGFloat
    {
        return UILabel.heightForLabel(text: text, font: lblDescription.font, width: UIScreen.main.bounds.size.width - 80)
    }
}

