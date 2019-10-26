//
//  ShowEpisodesViewController.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/11.
//  Copyright © 2019 MajestykApps. All rights reserved.
//
import UIKit
class ShowEpisodesViewController: BaseViewController {
    //    @IBOutlet weak var tblShow: UITableView!
    @IBOutlet weak var episodeTableView: UITableView!
    @IBOutlet var headerView: UIView!
    var show: Show?
    var shows: [Show] = Show.samples() ?? []
    override func viewDidLoad() {
        configure()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    func configure()
    {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.medium(size: 17)]
//        self.title = show?.category
        let btnBack = UIBarButtonItem(image: UIImage(named: "icon_back_black"), style: .plain, target: self, action: #selector(onBack(_:)))
        self.navigationItem.leftBarButtonItem = btnBack
        
        let btnLike = UIButton(image: UIImage(named: "icon_heart_black"), selectedImage: UIImage(named: "icon_heart_filled"), action: #selector(onLike(_:)), target: self)
        btnLike.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnLike)
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 750 * 478 )
        self.episodeTableView.tableHeaderView = headerView
        
        self.episodeTableView.register(EpisodesCell.self, forCellReuseIdentifier: EpisodesCell.identifier)
        self.episodeTableView.register(ClotheCell.self, forCellReuseIdentifier: ClotheCell.identifier)
        
        episodeTableView.dataSource = self
        episodeTableView.delegate = self
    }

    @objc func onBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onLike(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
    }
}

extension ShowEpisodesViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if( section == 0)
        {
            return 1
        }else{
            return shows.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
        let cell: EpisodesCell = tableView.dequeueReusableCell(withIdentifier: EpisodesCell.identifier, for: indexPath) as! EpisodesCell
        cell.indexPath = indexPath
        cell.tableView = tableView
        cell.controller = self
        
        return cell
        }else{
            let cell: ClotheCell = tableView.dequeueReusableCell(withIdentifier: ClotheCell.identifier, for: indexPath) as! ClotheCell
            cell.indexPath = indexPath
            cell.tableView = tableView
            cell.controller = self
            cell.reset(with: shows[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return EpisodesCell.height
        }else{
            return ClotheCell.height
        }
    }
}

extension ShowEpisodesViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


