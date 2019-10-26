//
//  NotificationsTableViewController.swift
//  TAGit
//  
//  Created by Joseph Hyun Lee on 5/3/19
//  Copyright © 2019 Joseph. All Rights Reserved.
//  

import UIKit

class NotificationsViewController: BaseViewController {

    @IBOutlet weak var notificationTable: UITableView!
    var notifications:[NotificationModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

       self.configure()
        load()
    }
    
    func configure()
    {
        self.notificationTable.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.identifier)
        self.notificationTable.dataSource = self
        self.notificationTable.delegate = self
    }
    
    func load()
    {
        notifications = NotificationModel.samples() ?? []
        self.notificationTable.reloadData()
    }
}

extension NotificationsViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationCell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.identifier, for: indexPath) as! NotificationCell
        cell.indexPath = indexPath
        cell.tableView = tableView
        cell.controller = self
        cell.reset(with: self.notifications[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NotificationCell.height
    }
    
}
extension NotificationsViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
