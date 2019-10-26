//
//  HomeCollectionViewFooter.swift
//  TAGit
//
//  Created by Liu Jie on 2019/6/29.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit
import Kingfisher
protocol HomeCollectionViewFooterDelegate {
    func didClickTagFavorite()
}
class HomeCollectionViewFooter: UICollectionReusableView {
    class var identifier: String {
        return "HomeCollectionViewFooter"
    }
    var lblTitle: UILabel!
    var lblDescription: UILabel!
    var btnTagFavorite: DefaultButton!
    var viewContainer: UIView!
    
    var delegate:HomeCollectionViewFooterDelegate?
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
        viewContainer.backgroundColor = UIColor.groupTableViewBackground
        self.addSubview(viewContainer)
        viewContainer.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(12)
            $0.right.equalToSuperview().offset(-12)
            $0.bottom.equalToSuperview().offset(-12)
        }
        viewContainer.layer.cornerRadius = 8
        viewContainer.layer.masksToBounds = true
        
        btnTagFavorite = DefaultButton()
        btnTagFavorite.addTarget(self, action: #selector(onTagFavorite(_:)), for: .touchUpInside)
        btnTagFavorite.titleLabel?.font = UIFont.bold(size: 14)
        btnTagFavorite.setTitle("tag_your_favorite_shows_now".localized(), for: .normal)
        btnTagFavorite.setTitleColor(UIColor.appBlue, for: .normal)
        viewContainer.addSubview(btnTagFavorite)
        btnTagFavorite.snp.makeConstraints{
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        lblDescription = UILabel.init(font: UIFont.light(size: 14), color: UIColor.black, superView: viewContainer)
        lblDescription.numberOfLines = 0
        lblDescription.text = "want_new_looks_from_your_favorite_shows".localized()
        lblDescription.textAlignment = .center
        lblDescription.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
            $0.bottom.equalTo(btnTagFavorite.snp.top).offset(-40)
            $0.centerX.equalToSuperview()
        }
        lblTitle = UILabel.init(font: UIFont.medium(size: 24), color: .black, superView: viewContainer)
        lblTitle.textAlignment = .center
        lblTitle.text = "new_looks_episodes".localized()
        lblTitle.snp.makeConstraints {
            $0.bottom.equalTo(lblDescription.snp.top).offset(-50)
            $0.centerX.equalToSuperview()
        }
    }
    @objc
    func onTagFavorite(_ sender: Any) {
        print("a");
        self.delegate?.didClickTagFavorite()
    }
    
}
