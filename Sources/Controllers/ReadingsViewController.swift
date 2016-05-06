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
import RxSwift

class ReadingsTableViewController: UIViewController {

    //MARK: Class variables
    var device: DeviceType?
    
    let viewModel = ReadingsViewModel()
    let disposeBag = DisposeBag()
    
    var grandientBackgroundLayer = Gradient.mainGradient()
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: View controller delegate methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Live Readings"
        
//        tableView.dataSource = self
//        tableView.delegate = self
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorColor = UIColor(white: 1, alpha: 0.6)
        tableView.rowHeight = 60
        tableView.alpha = 0
        
        setupBackgroundViews()
        addRefreshControl()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        
        viewModel.readings
            .observeOn(MainScheduler.instance)
            .doOnCompleted {
                completed in
                UIView.animateWithDuration(0.4) {
                    self.tableView.alpha = 1
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            .doOnError {
                error in
                print(error)
            }
            .retry(3)
            .bindTo(tableView.rx_itemsWithCellIdentifier("dataCell",
                cellType: DataReadingTableViewCell.self)) {
                row, dataType, cell in
                cell.dataType = dataType
            }
            .addDisposableTo(disposeBag)
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
