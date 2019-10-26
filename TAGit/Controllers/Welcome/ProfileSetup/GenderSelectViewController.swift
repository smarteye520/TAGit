//
//  ProfileSetupViewController.swift
//  TAGit
//
//  Created by Macmini on 6/17/19.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import UIKit

class GenderSelectViewController: BaseViewController {
    var listOptions: [String]!
    var selectedOption: String?

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var tblOptions: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnNext.isEnabled = false
        
        tblOptions.register(OptionCell.self, forCellReuseIdentifier: OptionCell.identifier)
        tblOptions.allowsSelection = true
        
        load()
    }
    
    func load() {
        listOptions = ["female".localized(), "male".localized(), "non_binary".localized()]
        tblOptions.reloadData()
    }
    
    @IBAction func onNext(_ sender: Any) {
        //API call and update gender of the user
        
        //show tagging
//        performSegue(withIdentifier: "sid_tagging_options", sender: self)
        UIManager.showTaggingSetup()
    }
}


extension GenderSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedOption = listOptions?[indexPath.row]
        btnNext.isEnabled = selectedOption != nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return OptionCell.height
    }
}

extension GenderSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOptions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.identifier, for: indexPath) as! OptionCell
        cell.reset(with:  listOptions?[indexPath.row])
        return cell
    }
}
