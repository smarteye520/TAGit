//
//  NotificationCell.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/10.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit
import SnapKit

class NotificationCell: BaseTableViewCell {
    override class var height: CGFloat {
        return 96
    }
    
    override class var identifier: String {
        return "NotificationCell"
    }
    
    var imgShow: UIImageView!
    var lblContent: UILabel!
    var imgArrow: UIImageView!
    var imgBadge: UIImageView!
    
    func reset(with notification: NotificationModel) {
        lblContent.text = notification.message
        imgShow.kf.indicatorType = .activity
        if let imgUrl = notification.image {
            imgShow.kf.setImage(with: URL(string: imgUrl)) { [weak self] (image, error, type, url) in
                self?.layoutIfNeeded()
            }
        }
        if notification.isRead
        {
            lblContent.font = UIFont.light(size: 14)
            imgBadge.isHidden = true
        }else{
            lblContent.font = UIFont.medium(size: 14)
            imgBadge.isHidden = false
        }
    }
    
    override func configure() {
        super.configure()
        
        imgShow = UIImageView.init(contentMode: .scaleAspectFill, superView: self.contentView)
        imgShow.translatesAutoresizingMaskIntoConstraints = false
        imgShow.clipsToBounds = true
        imgShow.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.left.top.equalToSuperview().offset(8)
        }
        imgShow.layer.cornerRadius = 4
        imgShow.layer.masksToBounds = true
        
        imgArrow = UIImageView.init(contentMode: .scaleAspectFit, superView: self.contentView)
        imgArrow.translatesAutoresizingMaskIntoConstraints = false
        imgArrow.clipsToBounds = true
        imgArrow.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-16)
        }
        imgArrow.image = UIImage(named: "icon_arrow_right")
        
        imgBadge = UIImageView.init(contentMode: .scaleAspectFill, superView: self.contentView)
        imgBadge.translatesAutoresizingMaskIntoConstraints = false
        imgBadge.clipsToBounds = true
        imgBadge.snp.makeConstraints {
            $0.width.height.equalTo(11)
            $0.top.equalTo(imgShow.snp.top).offset(-5)
            $0.right.equalTo(imgShow.snp.right).offset(5)
        }
        imgBadge.contentMode = .scaleAspectFit
        imgBadge.image = UIImage(named: "icon_notification_badge")
        
        lblContent = UILabel.init(font: UIFont.light(size: 16), color: .black, superView: self.contentView)
        lblContent.snp.makeConstraints {
            $0.left.equalTo(imgShow.snp.right).offset(20)
            $0.top.equalTo(imgShow.snp.top)
            $0.right.equalTo(imgArrow.snp.left).offset(-12)
        }
        lblContent.numberOfLines = 0
    }
}

