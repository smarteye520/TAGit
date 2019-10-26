//
//  FavoriteClothesCollectionViewController.swift
//  TAGit
//  
//  Created by Joseph Hyun Lee on 5/1/19
//  Copyright © 2019 Joseph. All Rights Reserved.
//  

import UIKit
import XLPagerTabStrip


class FavoriteClothesViewController: UIViewController, IndicatorInfoProvider {
    @IBOutlet weak var clotheCollectionView: UICollectionView!
    var shows: [Show] = []
    var selectMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        load()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(selectButtonPressed(_:)), name: .FavoritesViewControllerSelectButtonPressed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cancelButtonPressed(_:)), name: .FavoritesViewControllerCancelButtonPressed, object: nil)
    }
    func bind() {
        
    }
    
    func load() {
        self.shows = Show.samples() ?? []
        clotheCollectionView.reloadData()
    }
    func configure() {
        clotheCollectionView.register(RelatedShowCell.self, forCellWithReuseIdentifier: RelatedShowCell.identifier)
        clotheCollectionView.delegate = self
        clotheCollectionView.dataSource = self
        
        if let layout = clotheCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
        }
    }
    
    @objc func selectButtonPressed(_ sender: UIButton) {
        print("Did receive select button pressed notification")
        selectMode = true
        self.clotheCollectionView.reloadData()
        
    }
    
    @objc func cancelButtonPressed(_ sender: UIButton) {
        selectMode = false
        self.clotheCollectionView.reloadData()
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "clothing".localized())
    }
}
extension FavoriteClothesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RelatedShowCell = collectionView.dequeueReusableCell(withReuseIdentifier: RelatedShowCell.identifier, for: indexPath) as! RelatedShowCell
        cell.indexPath = indexPath
        cell.collectionView = collectionView
        cell.controller = self
        cell.isSelectable = self.selectMode
        cell.reset(with: self.shows[indexPath.row])
        
        return cell
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
extension FavoriteClothesViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 12, height: collectionView.frame.width/2 + 20)
    }
}

