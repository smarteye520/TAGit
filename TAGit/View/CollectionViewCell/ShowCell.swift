//
//  ShowCell.swift
//  TAGit
//
//  Created by Macmini on 6/18/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit
import Kingfisher
protocol ShowCellDelegate {
    func didClickCategory(_ show: Show?)
}
class ShowCell: BaseCollectionViewCell {
    class var identifier: String {
        return "ShowCell"
    }
    
    var imgShow: UIImageView!
    
    var container: UIView!
    var lblTitle: UILabel!
    var lblDescription: UILabel!
    var btnLike: UIButton!
    var btnTag: UIButton!
    var btnCategory: UIButton!
    var delegate: ShowCellDelegate?
    
    weak var show: Show?
    
    func reset(with show: Show?) {
        self.show = show
        
        lblTitle.text = show?.title
        lblDescription.text = ShowViewModel.description(show: show)
        imgShow.kf.indicatorType = .activity
        if let imgUrl = show?.image {
            imgShow.kf.setImage(with: URL(string: imgUrl)) { [weak self] (image, error, type, url) in
                self?.layoutIfNeeded()
            }
        }
    }
    
    override func configure() {
        super.configure()
        
        //Description
        container = UIView(frame: .zero)
        self.contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.left.right.equalToSuperview()
        }
        
        btnLike = UIButton.init(image: UIImage(named: "icon_heart_black"), selectedImage: UIImage(named: "icon_heart_blue_bordered"), action: #selector(onLike(_:)), target: self, superView: container)
        btnTag = UIButton.init(image: UIImage(named: "icon_shop_pin_black"), action: #selector(onTag(_:)), target: self, superView: container)
        
        btnTag.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(12)
            $0.right.equalToSuperview().offset(-12)
        }
        btnLike.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalTo(btnTag)
            $0.right.equalTo(btnTag.snp.left).offset(-15)
        }
        
        
        lblTitle = UILabel.init(font: UIFont.regular(size: 16), color: .black, superView: container)
        lblTitle.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(12)
            $0.right.equalTo(btnLike.snp.left).offset(-8)
        }
        
        lblDescription = UILabel.init(font: UIFont.regular(size: 12), color: .appBlue, superView: container)
        lblDescription.snp.makeConstraints {
            $0.left.equalTo(lblTitle.snp.left)
            $0.top.equalTo(lblTitle.snp.bottom).offset(0)
        }
        
        btnCategory = UIButton.init(image: nil, action: #selector(onCategory(_:)), target: self, superView: container)
        btnCategory.snp.makeConstraints {
            $0.left.top.right.bottom.equalTo(lblDescription)
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-60)
        }
        
        //Image
        imgShow = UIImageView.init(contentMode: .scaleAspectFill, superView: stackView)
        imgShow.translatesAutoresizingMaskIntoConstraints = false
        imgShow.clipsToBounds = true
        imgShow.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.left.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc
    func onLike(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc
    func onTag(_ sender: Any) {
        
    }
    
    @objc
    func onCategory(_ sender: Any) {
        self.delegate?.didClickCategory(self.show)
    }
}
