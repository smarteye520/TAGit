//
//  TaggingViewController.swift
//  TAGit
//
//  Created by Macmini on 6/17/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class TaggingOptionsViewController: BaseViewController {
    @IBOutlet weak var collectionOptions: UICollectionView!
    @IBOutlet weak var btnNext: DefaultButton!
    
    var listOptions: [CategoryModel] = []
    var selectedOptions: [CategoryModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        load()
    }
    
    func configure() {
        btnNext.isEnabled = false
        
        collectionOptions.register(TaggingCollectionViewCell.self, forCellWithReuseIdentifier: TaggingCollectionViewCell.identifier)
        collectionOptions.allowsMultipleSelection = true
        guard let layout = collectionOptions.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.minimumLineSpacing = 10
    }
    
    func load() {
        API.shared.getCategories(page: 1, limit: 100)
            .done{ (categories) in
                self.listOptions = categories
                self.collectionOptions.reloadData()
            }.catch { (error) in
                self.showError(text: error.localizedDescription)
        }
        
    }
    
    @IBAction func onNext(_ sender: Any) {
        //API Call to update tagging of user
        
        //Show Next
        let ids: [String] = selectedOptions.map{ String($0.id!) }
        API.shared.selectCategories(selectedIds: ids).done{ (success) in
            if (success)
            {
                AppManager.shared.isProfileCompleted = true
                AppManager.shared.showNext()
            }
            }.catch{ (error) in
                self.showError(text: error.localizedDescription)
        }
        
    }
    
    func checkInput() {
        btnNext.isEnabled = (collectionOptions.indexPathsForSelectedItems?.count ?? 0) > 2
    }
}

extension TaggingOptionsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TaggingCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TaggingCollectionViewCell.identifier, for: indexPath) as! TaggingCollectionViewCell
        cell.indexPath = indexPath
        cell.collectionView = collectionView
        cell.controller = self
        cell.reset(with: listOptions[indexPath.item].title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        checkInput()
        if !selectedOptions.contains(listOptions[indexPath.row])
        {
            selectedOptions.append(listOptions[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        checkInput()
         if selectedOptions.contains(listOptions[indexPath.row])
         {
            selectedOptions.remove(at: selectedOptions.index(of: listOptions[indexPath.row])!)
        }
    }
}

extension TaggingOptionsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 5
        return CGSize(width: width, height: TaggingCollectionViewCell.height)
    }
}
