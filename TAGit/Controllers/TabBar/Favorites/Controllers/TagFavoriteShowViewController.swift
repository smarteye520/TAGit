//
//  TagFavoriteShowViewController.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/12.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class TagFavoriteShowViewController: BaseViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    var selectMode = false
    var tvShows:[TVShow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        load()
    }
    
    
    func configure() {
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.enable = false
        txtSearch.delegate = self
        
        collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        collectionView.register(TagFavoriteFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: TagFavoriteFooterView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
        }
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.identifier)
    }
    
    func load() {
        tvShows = TVShow.samples() ?? []
        tvShows += TVShow.samples() ?? []
        collectionView.reloadData()
        perform(#selector(showAlert(_:)), with: self, afterDelay: 2.0)
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func showAlert(_ sender: Any) {
        let alertController = UIAlertController.init(
            title: "tag_favorite_alert_title".localized(),
            message: "tag_favorite_alert_message".localized(),
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction.init(title: "no_thanks".localized(), style: UIAlertAction.Style.cancel, handler: nil))
        alertController.addAction(UIAlertAction.init(title:"add_show".localized(), style: UIAlertAction.Style.default, handler: { (action) in
            
            self.selectMode = true
            self.collectionView.reloadData()
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension TagFavoriteShowViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if txtSearch.text?.isEmpty ?? true
        {
            return tvShows.count
        }
        return tvShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TVCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
        cell.indexPath = indexPath
        cell.collectionView = collectionView
        cell.controller = self
        cell.isSelectable = selectMode
        cell.imgShow.layer.cornerRadius = 4
        cell.imgShow.layer.masksToBounds = true
        cell.reset(with: self.tvShows[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {

        case UICollectionView.elementKindSectionHeader:
            return UICollectionReusableView()

        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TagFavoriteFooterView.identifier, for: indexPath as IndexPath) as! TagFavoriteFooterView
            footerView.delegate = self
            return footerView

        default:

            return UICollectionReusableView()
        }
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
extension TagFavoriteShowViewController:UICollectionViewDelegateFlowLayout
{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 50)
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 170.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 12, height: (collectionView.frame.width/2 - 12) / 2 + 30)
    }
}
extension TagFavoriteShowViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.collectionView.reloadData()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.collectionView.reloadData()
        return true
    }
}
extension TagFavoriteShowViewController: TagFavoriteFooterViewDelegate
{
    func didClickCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func didClickDone() {
        // add shows to favorite implement
        dismiss(animated: true, completion: nil)
    }
}
