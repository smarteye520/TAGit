//
//  FavoriteTVShowsCollectionViewController.swift
//  TAGit
//  
//  Created by Joseph Hyun Lee on 5/1/19
//  Copyright © 2019 Joseph. All Rights Reserved.
//  

import UIKit
import XLPagerTabStrip
/*
 TODO:
 - TagFavoriteShowsView and TagFavoriteShowsViewDelegate
 - Delete button image
 */

class FavoriteTVShowsViewController: UIViewController, IndicatorInfoProvider {
    @IBOutlet weak var tvShowCollectionView: UICollectionView!
    var selectMode = false
    var networks:[String] = ["ABC Network", "NBC Network", "CW TV"]
    override func viewDidLoad() {
        // TODO:
        // if viewModel is empty, then show the addToFavoritesView
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tvShowCollectionView.reloadData()
        // Subscribe to FavoritesParentViewController notification
        NotificationCenter.default.addObserver(self, selector: #selector(selectButtonPressed(_:)), name: .FavoritesViewControllerSelectButtonPressed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cancelButtonPressed(_:)), name: .FavoritesViewControllerCancelButtonPressed, object: nil)
        
    }
    func configure(){
        tvShowCollectionView.register(TVShowCollectionViewCell.self, forCellWithReuseIdentifier: TVShowCollectionViewCell.identifier)
        tvShowCollectionView.delegate = self
        tvShowCollectionView.dataSource = self
        if let layout = tvShowCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
        }
    }
    @objc func selectButtonPressed(_ sender: UIButton) {
        print("Did receive select button pressed notification")
        selectMode = true
        self.tvShowCollectionView.reloadData()
        
    }
    
    @objc func cancelButtonPressed(_ sender: UIButton) {
        selectMode = false
        self.tvShowCollectionView.reloadData()
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "shows".localized())
    }
}
extension FavoriteTVShowsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: TVShowCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.identifier, for: indexPath) as! TVShowCollectionViewCell
        cell.indexPath = indexPath
        cell.collectionView = collectionView
        cell.controller = self
        cell.selectMode = selectMode
        cell.delegate = self
        cell.reset(with: [], networks[indexPath.row])
        
        return cell
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
extension FavoriteTVShowsViewController:UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3 + 125)
    }
}

extension FavoriteTVShowsViewController: TVShowCollectionViewCellDelegate
{
    func didSelectTVShow(tvShow: TVShow) {
        let showEpisodesVC = UIManager.loadViewController(storyboard: "Home", controller: "ShowEpisodesViewController") as! ShowEpisodesViewController
        showEpisodesVC.title = tvShow.title
        self.navigationController?.pushViewController(showEpisodesVC, animated: true)
    }
}
