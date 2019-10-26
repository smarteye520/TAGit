//
//  EpisodesCell.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/11.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit
import SnapKit

class EpisodesCell: BaseTableViewCell {
    var tvShows: [TVShow] = TVShow.samples() ?? []
    var selectedIndexPath: IndexPath! = IndexPath(row: 0, section: 0)
    override class var height: CGFloat {
        return 230
    }
    
    override class var identifier: String {
        return "EpisodesCell"
    }
    
    var lblHeaderTitle: UILabel!
    var episodesCollectionView: UICollectionView!
    var lblFooterTitle: UILabel!
    var btnSeason: UIButton!
    let dropDown = DropDown()
    
    func reset(with notification: NotificationModel) {
        
    }
    
    override func configure() {
        super.configure()
        lblHeaderTitle = UILabel.init(font: UIFont.medium(size: 18), color: .black, superView: self.contentView)
        lblHeaderTitle.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(12)
        }
        lblHeaderTitle.text = "episodes".localized()
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        episodesCollectionView = UICollectionView.init(frame: self.contentView.frame, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.contentView.addSubview(episodesCollectionView)
        episodesCollectionView.showsHorizontalScrollIndicator = false
        episodesCollectionView.backgroundColor = UIColor.white
        episodesCollectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(lblHeaderTitle.snp.bottom).offset(12)
            $0.height.equalTo(140)
        }
        episodesCollectionView.dataSource = self
        episodesCollectionView.delegate = self
        episodesCollectionView.register(EpisodeCell.self, forCellWithReuseIdentifier: EpisodeCell.identifier)
        
        lblFooterTitle = UILabel.init(font: UIFont.medium(size: 18), color: .black, superView: self.contentView)
        lblFooterTitle.snp.makeConstraints {
            $0.left.equalTo(lblHeaderTitle.snp.left)
            $0.top.equalTo(episodesCollectionView.snp.bottom)
        }
        
        lblFooterTitle.text = "looks_from_this_episode".localized()
        btnSeason = UIButton.init(image: UIImage(named: "icon_arrow_down"), action: #selector(selectSeason(_:)), target: self, superView: self.contentView)
        btnSeason.setTitle("Season 1 ", for: .normal)
        btnSeason.setTitleColor(UIColor.black, for: .normal)
        btnSeason.titleLabel?.font = UIFont.light(size: 16)
        btnSeason.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-12)
            $0.bottom.equalTo(lblHeaderTitle.snp.bottom)
        }
        btnSeason.semanticContentAttribute = .forceRightToLeft
        btnSeason.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        dropDown.anchorView = btnSeason
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        dropDown.bottomOffset = CGPoint(x: 0, y: 30)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        dropDown.dataSource = [
            "Season 1",
            "Season 2",
            "Season 3",
            "Season 4",
            "Season 5",
            "Season 6",
            "Season 7",
            "Season 8",
            "Season 9",
            "Season 10",
            "Season 11",
            "Season 12"
        ]
        
        // Action triggered on selection
        dropDown.selectionAction = { [weak self] (index, item) in
            self?.btnSeason.setTitle("\(item) ", for: .normal)
        }
        dropDown.direction = .bottom
        dropDown.dismissMode = .onTap
        dropDown.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self))
        dropDown.customCellConfiguration = nil
        dropDown.textFont = UIFont.light(size: 16)
    }
    
    @objc
    func selectSeason(_ sender: Any) {
        dropDown.show()
    }
}

extension EpisodesCell: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EpisodeCell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCell.identifier, for: indexPath) as! EpisodeCell
        cell.indexPath = indexPath
        if indexPath.row == selectedIndexPath.row
        {
            cell.selectedItem = true
        }else{
            cell.selectedItem = false
        }
        cell.reset(with: self.tvShows[indexPath.row])
        cell.lblTitle.text = "Episode \(indexPath.row + 1)"
        
        return cell
        
    }
}
extension EpisodesCell: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        self.episodesCollectionView.reloadData()
    }
}
extension EpisodesCell:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 140)
    }
}



