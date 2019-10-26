//
//  TVShowCollectionViewCell.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/8.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit
protocol TVShowCollectionViewCellDelegate {
    func didSelectTVShow(tvShow: TVShow)
}
class TVShowCollectionViewCell: BaseCollectionViewCell {
    class var identifier: String {
        return "TVShowCollectionViewCell"
    }
    var selectMode = false
    var tvShowCollectionView: UICollectionView!
    var lblNetwork: UILabel!
    var tvShows:[TVShow] = []
    var delegate: TVShowCollectionViewCellDelegate?
    func reset(with show: [TVShow]?, _ network: String?) {
        if let title = network
        {
            tvShowCollectionView.snp.updateConstraints {
                $0.top.equalToSuperview().offset(50)
            }
            lblNetwork.text = title
            lblNetwork.isHidden = false
        }else{
            tvShowCollectionView.snp.updateConstraints {
                $0.top.equalToSuperview().offset(0)
            }
            lblNetwork.isHidden = true
        }
        tvShows = TVShow.samples() ?? []
        self.tvShowCollectionView.reloadData()
    }
    
    override func configure() {
        super.configure()
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        tvShowCollectionView = UICollectionView.init(frame: self.contentView.frame, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.contentView.addSubview(tvShowCollectionView)
        tvShowCollectionView.backgroundColor = UIColor.white
        tvShowCollectionView.snp.makeConstraints {
            $0.bottom.left.right.top.equalToSuperview()
        }
        tvShowCollectionView.dataSource = self
        tvShowCollectionView.delegate = self
        tvShowCollectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        
        lblNetwork = UILabel.init(font: UIFont.medium(size: 17), color: .black, superView: self.contentView)
        lblNetwork.snp.makeConstraints {
            $0.left.equalToSuperview().offset(12)
            $0.bottom.equalTo(self.tvShowCollectionView.snp.top).offset(-10)
        }
        lblNetwork.isHidden = true
    }
}
extension TVShowCollectionViewCell: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TVCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
        cell.indexPath = indexPath
        cell.collectionView = tvShowCollectionView
        cell.controller = self.controller
        cell.isSelectable = selectMode
        cell.reset(with: self.tvShows[indexPath.row])
        
        return cell
        
    }
    
    
}
extension TVShowCollectionViewCell: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectTVShow(tvShow: tvShows[indexPath.row])
    }
}
extension TVShowCollectionViewCell:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3 + 20, height: collectionView.frame.size.height)
    }
}
