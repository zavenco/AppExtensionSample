//
//  ViewController.swift
//  AppExtensionSample
//
//  Created by Paweł Kuźniak on 25.03.2016.
//  Copyright © 2016 Paweł Kuźniak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.viewWillEnterForeground(_:)), name:UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    func viewWillEnterForeground(notification: NSNotification){
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalStorageManager.sharedInstance.readData().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = LocalStorageManager.sharedInstance.readData()[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let remove = UITableViewRowAction(style: .Destructive, title: "Remove") { action, index in
            LocalStorageManager.sharedInstance.removeData(index.row)
            self.tableView.reloadData()
        }
        return [remove]
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}

