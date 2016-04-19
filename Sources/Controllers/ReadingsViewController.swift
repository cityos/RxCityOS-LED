//
//  ReadingsTableViewController.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import CoreCityOS
import LightFactory

class ReadingsTableViewController: UIViewController {

    //MARK: Class variables
    var device: DeviceType?
    
    var grandientBackgroundLayer = Gradient.mainGradient()
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: View controller delegate methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Live Readings"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorColor = UIColor(white: 1, alpha: 0.6)
        tableView.rowHeight = 60
        tableView.alpha = 0
        
        setupBackgroundViews()
        addRefreshControl()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        LightFactory.sharedInstance.retrieveLatestLampData(limit: 1) {
            response in
            if let device = response.data?.first {
                dispatch_async(dispatch_get_main_queue(), {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    self.device = device
                    self.tableView.reloadData()
                    UIView.animateWithDuration(0.4) {
                        self.tableView.alpha = 1
                    }
                })
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        grandientBackgroundLayer.frame = self.view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ReadingsTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let device = device {
            return device.dataCollection.allReadings.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dataCell", forIndexPath: indexPath) as! DataReadingTableViewCell
        
        cell.dataType = device?.dataCollection.allReadings[indexPath.row]
        cell.contentView.backgroundColor = .clearColor()
        cell.backgroundColor = .clearColor()
        return cell
    }
}

extension ReadingsTableViewController {
    func setupBackgroundViews() {
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        grandientBackgroundLayer.frame = view.bounds
        view.layer.insertSublayer(grandientBackgroundLayer, atIndex: 0)
    }
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.whiteColor()
        
        refreshControl.addTarget(
            self,
            action: #selector(refresh(_:)),
            forControlEvents: .ValueChanged
        )
        self.tableView.addSubview(refreshControl)
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
}
