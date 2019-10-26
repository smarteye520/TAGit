//
//  DetailShowViewController.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/2.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit
class DetailShowViewController: BaseViewController {
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionViewShow: UICollectionView!
    var shows: [Show] = []
    var show: Show!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        load()
    }
    
    
    func configure() {
        lblTitle.text = show.title
        lblDescription.text = ShowViewModel.description(show: show)
        collectionViewShow.register(RelatedShowCell.self, forCellWithReuseIdentifier: RelatedShowCell.identifier)
        collectionViewShow.delegate = self
        collectionViewShow.dataSource = self
        
        if let layout = collectionViewShow.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
        }
        collectionViewShow.register(DetailCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailCollectionViewHeader.identifier)
    }
    
    func load() {
        self.shows = Show.samples() ?? []
        collectionViewShow.reloadData()
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailShowViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
        cell.reset(with: self.shows[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailCollectionViewHeader.identifier, for: indexPath as IndexPath) as! DetailCollectionViewHeader
            
            headerView.show = self.show
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            return UICollectionReusableView()
            
        default:
            
            return UICollectionReusableView()
        }
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
extension DetailShowViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 600)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 12, height: collectionView.frame.width/2 - 12)
    }
}

