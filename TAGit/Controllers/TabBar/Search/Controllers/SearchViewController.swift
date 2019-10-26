//
//  SearchViewController.swift
//  TAGit
//  
//  Created by Joseph Hyun Lee on 5/3/19
//  Copyright © 2019 Joseph. All Rights Reserved.
//  

import UIKit
import IQKeyboardManagerSwift

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    var shows: [Show] = []
    @IBOutlet weak var collectionViewSearch: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        load()
    }
    
    
    func configure() {
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.enable = false
        txtSearch.delegate = self
        collectionViewSearch.register(ShowCell.self, forCellWithReuseIdentifier: ShowCell.identifier)
        collectionViewSearch.register(TVShowCollectionViewCell.self, forCellWithReuseIdentifier: TVShowCollectionViewCell.identifier)
        collectionViewSearch.delegate = self
        collectionViewSearch.dataSource = self
        
        if let layout = collectionViewSearch.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
        }
        collectionViewSearch.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.identifier)
    }
    
    func load() {
        self.shows = Show.samples() ?? []
        collectionViewSearch.reloadData()
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if txtSearch.text?.isEmpty ?? true
        {
            return 1
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if txtSearch.text?.isEmpty ?? true
        {
            return shows.count
        }else{
            switch section {
                
            case 0:
                return 1
            case 1:
                return shows.count
            default:
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if txtSearch.text?.isEmpty ?? true
        {
            let cell: ShowCell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCell.identifier, for: indexPath) as! ShowCell
            cell.indexPath = indexPath
            cell.collectionView = collectionView
            cell.controller = self
            cell.reset(with: self.shows[indexPath.row])
            
            return cell
        }else{
            if(indexPath.section == 0)
            {
                let cell: TVShowCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.identifier, for: indexPath) as! TVShowCollectionViewCell
                cell.indexPath = indexPath
                cell.collectionView = collectionView
                cell.controller = self
                cell.reset(with: [], nil)
                
                return cell
            }else{
                let cell: ShowCell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCell.identifier, for: indexPath) as! ShowCell
                cell.indexPath = indexPath
                cell.collectionView = collectionView
                cell.controller = self
                cell.reset(with: self.shows[indexPath.row])
                
                return cell
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewHeader.identifier, for: indexPath as IndexPath) as! CollectionViewHeader
            if txtSearch.text?.isEmpty ?? true
            {
                headerView.lblTitle.text = "suggested_for_you".localized()
                headerView.lblTitle.textColor = UIColor.appGray
                headerView.lblTitle.font = UIFont(name: UIFont.AppFont.Regular, size: 17)
            }else{
                if(indexPath.section == 0)
                {
                    headerView.lblTitle.text = "shows".localized()
                    headerView.lblTitle.textColor = UIColor.appGray
                    headerView.lblTitle.font = UIFont(name: UIFont.AppFont.Regular, size: 17)
                }else{
                    headerView.lblTitle.text = "items".localized()
                    headerView.lblTitle.textColor = UIColor.appGray
                    headerView.lblTitle.font = UIFont(name: UIFont.AppFont.Regular, size: 17)
                }
            }
            
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            return UICollectionReusableView()
            
        default:
            
            return UICollectionReusableView()
        }
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let controller = UIManager.loadViewController(storyboard: "Home", controller:"DetailShowViewController") as? DetailShowViewController else {
            return
        }
        controller.show = shows[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
extension SearchViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if txtSearch.text?.isEmpty ?? true
        {
            return CGSize(width: collectionView.frame.width/2 - 12, height: collectionView.frame.width/2 - 12 + 60)
        }else{
            switch indexPath.section {
            case 0:
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3 + 50)
            default:
                return CGSize(width: collectionView.frame.width/2 - 12, height: collectionView.frame.width/2 - 12 + 60)
            }
        }
    }
}
extension SearchViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.collectionViewSearch.reloadData()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.collectionViewSearch.reloadData()
        return true
    }
}


