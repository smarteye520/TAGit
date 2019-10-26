//
//  CollectionReusableView.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/12.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

protocol TagFavoriteFooterViewDelegate {
    func didClickDone()
    func didClickCancel()
}
class TagFavoriteFooterView: UICollectionReusableView {
    class var identifier: String {
        return "TagFavoriteFooterView"
    }
    var btnSave: DefaultButton!
    var btnCancel: UIButton!
    
    var delegate:TagFavoriteFooterViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.configure()
    }
    
    func configure() {
    
        btnSave = DefaultButton()
        btnSave.addTarget(self, action: #selector(onDone(_:)), for: .touchUpInside)
        btnSave.titleLabel?.font = UIFont.regular(size: 17)
        btnSave.setTitle("done".localized(), for: .normal)
        btnSave.setTitleColor(UIColor.appBlue, for: .normal)
        self.addSubview(btnSave)
        btnSave.snp.makeConstraints{
            $0.top.equalToSuperview().offset(40)
            $0.height.equalTo(50)
            $0.width.equalTo(160)
            $0.centerX.equalToSuperview()
        }
        
        btnCancel = UIButton(type: .custom)
        btnCancel.addTarget(self, action: #selector(onCancel(_:)), for: .touchUpInside)
        btnCancel.titleLabel?.font = UIFont.regular(size: 17)
        btnCancel.setTitle("cancel".localized(), for: .normal)
        btnCancel.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(btnCancel)
        btnCancel.snp.makeConstraints{
            $0.top.equalTo(btnSave.snp.bottom).offset(20)
            $0.height.equalTo(50)
            $0.width.equalTo(160)
            $0.centerX.equalToSuperview()
        }
    }
    @objc
    func onDone(_ sender: Any) {
        print("a");
        self.delegate?.didClickDone()
    }
    
    @objc
    func onCancel(_ sender: Any) {
        print("a");
        self.delegate?.didClickCancel()
    }
    
}

