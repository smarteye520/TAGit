//
//  FavoriteTVShowsCollectionViewController.swift
//  TAGit
//  
//  Created by Joseph Hyun Lee on 5/1/19
//  Copyright © 2019 Joseph. All Rights Reserved.
//  

import UIKit

/*
 TODO:
 - TagFavoriteShowsView and TagFavoriteShowsViewDelegate
 - Delete button image
 */

class FavoriteTVShowsViewController: BaseViewController {
    private let reuseIdentifier = "Cell"
    var tagFavoriteShowsView: TagFavoriteShowsView!
    var tagFavoriteShowsDeleteButton: UIButton!
    var selectMode = false
    override func viewDidLoad() {
        // TODO:
        // if viewModel is empty, then show the addToFavoritesView
        super.viewDidLoad()
        setup()
        bind()
    }
    
    func bind() {
        
    }
    
    func setup() {
        setupCollectionView()
        setupTagFavoriteShowsView()
        setupDeleteButton()
        showTagFavoriteShowsView()
        hideDeleteFavoriteShowsButton()

        // Subscribe to FavoritesParentViewController notification
        NotificationCenter.default.addObserver(self, selector: #selector(selectButtonPressed(_:)), name: .FavoritesViewControllerSelectButtonPressed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cancelButtonPressed(_:)), name: .FavoritesViewControllerCancelButtonPressed, object: nil)
    }
    
    func setupCollectionView() {
        
    }
    
    func setupTagFavoriteShowsView() {
       
    }
    
    func setupDeleteButton() {
       
    }
    
    @objc func selectButtonPressed(_ sender: UIButton) {
        print("Did receive select button pressed notification")
        
    }
    
    @objc func cancelButtonPressed(_ sender: UIButton) {
        
    }
    
    @objc func tagFavoriteShowsDeleteButtonPressed(_ sender: UIButton) {
        
        
    }

    // MARK: - Helpers
    // MARK: TagFavoriteShows
    func showTagFavoriteShowsView() {
        // If the user's favorite shows is empty, show this vie
    }
    
    func hideTagFavoriteShowsView() {
    }
    
    // MARK: Delete button
    func showDeleteFavoriteShowsButton() {
        
        
    }
    
    func hideDeleteFavoriteShowsButton() {
        
    }
}

//// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
//extension FavoriteTVShowsCollectionViewController {
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // [START debug]
//        return 1
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // [START debug]
//        return 3
//        // [END debug]
//
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return cell
//    }
//
//     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//     }
//
//}

// MARK: - FavoritesTVShowCollectionViewCell Delegate
//extension FavoriteTVShowsCollectionViewController: FavoritesTVShowCollectionViewCellDelegate {
//    func numberOfItems(_ cell: FavoritesTVShowCollectionViewCell) -> Int {
//        guard let indexPath = collectionView.indexPath(for: cell) else {
//            return 0
//        }
//        // NOTE: FavoriteTVShowsCollectionViewController only has 1 section
//        // Each row acts as the section for FavoritesTVShowCollectionViewCell
//        let section = indexPath.item
//        return viewModel.numberOfItems(in: section)
//    }
//
//    func favoriteTVShow(_ cell: FavoritesTVShowCollectionViewCell, at indexPath: IndexPath) -> TVShow {
//        // Keep track of cell provided index path
//        let section = collectionView.indexPath(for: cell)!.item
//        let item = indexPath.item
//        return viewModel.tvShows(at: section)[item]
//    }
//
//    func didSelectItem(_ cell: FavoritesTVShowCollectionViewCell, at indexPath: IndexPath) {
//        // TODO: Add to viewModel
//
//        if selectMode {
//            // let favoriteShow = viewModel.tvShow(at: indexPath)
//            let section = collectionView.indexPath(for: cell)!.item
//            let item = indexPath.item
//            print("DIDSELECTITEM")
//            let favoriteShow = viewModel.tvShows(at: section)[item]
//            viewModel.didSelectFavoriteShow(favoriteShow)
//            tagFavoriteShowsDeleteButton.isEnabled = viewModel.selectedItemsCount > 0
//        } else {
//            // TODO: FavoriteTVShowDetailedViewController
//        }
//    }
//
//    func didDeselectItem(_ cell: FavoritesTVShowCollectionViewCell, at indexPath: IndexPath) {
//        print("Did deselect item at indexPath")
//    }
//
//    func shouldSelectItem(_ cell: FavoritesTVShowCollectionViewCell, at indexPath: IndexPath) -> Bool {
//        let tvShow = self.favoriteTVShow(cell, at: indexPath)
//        return viewModel.containsSelectedFavoriteShow(tvShow)
//    }
//}

// MARK: - TagFavoriteShowsView Delegate
//extension FavoriteTVShowsCollectionViewController: TagFavoriteShowsViewDelegate {
//    func tagFavoriteShowsView(_ tagFavoriteShowsView: TagFavoriteShowsView, didPressTagFavoriteShowsButton favoriteShowsButton: UIButton) {
//        // TODO: Create TagFavoriteShowsDetailViewController
//        print("Did press tag favorite shows button")
//    }
//}
