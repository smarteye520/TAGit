//
//  HomeViewController.swift
//  TAGit
//
//  Created by Macmini on 6/18/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
//    @IBOutlet weak var tblShow: UITableView!
    @IBOutlet weak var collectionViewShow: UICollectionView!
    var products: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        load()
    }
    
    func configure() {
        collectionViewShow.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionViewShow.delegate = self
        collectionViewShow.dataSource = self
        
        if let layout = collectionViewShow.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
        }
        collectionViewShow.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.identifier)
        collectionViewShow.register(HomeCollectionViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeCollectionViewFooter.identifier)
    }
    
    func load() {
        API.shared.getProducts(page: 1, limit: 20).done{ (products) in
            self.products = products
            self.collectionViewShow.reloadData()
            }.catch{ (error) in
                self.showError(text: error.localizedDescription)
        }
       
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        cell.indexPath = indexPath
        cell.collectionView = collectionView
        cell.controller = self
        cell.delegate = self
        cell.reset(with: self.products[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewHeader.identifier, for: indexPath as IndexPath) as! CollectionViewHeader
            
            headerView.lblTitle.text = "picked_just_for_you".localized()
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionViewFooter.identifier, for: indexPath as IndexPath) as! HomeCollectionViewFooter
            footerView.delegate = self
            return footerView
            
        default:
            
            return UICollectionReusableView()
        }
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let controller = UIManager.loadViewController(storyboard: "Home", controller:"DetailShowViewController") as? DetailShowViewController else {
//            return
//        }
//        controller.show = products[indexPath.row]
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
extension HomeViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 294.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 12, height: collectionView.frame.width/2 - 12 + 60)
    }
}

extension HomeViewController: ProductCellDelegate
{
    func didClickCategory(_ product: ProductModel?) {
//        let showEpisodesVC = UIManager.loadViewController(storyboard: "Home", controller: "ShowEpisodesViewController") as! ShowEpisodesViewController
//        if let item = show
//        {
//            showEpisodesVC.title = item.category
//            self.navigationController?.pushViewController(showEpisodesVC, animated: true)
//        }
    }
}
extension HomeViewController: HomeCollectionViewFooterDelegate
{
    func didClickTagFavorite() {
        let viewcontroller = UIManager.loadViewController(storyboard: "Favorites", controller: "TagFavoriteShowViewController") as! TagFavoriteShowViewController
        present(viewcontroller, animated: true, completion: nil)
    }
}

