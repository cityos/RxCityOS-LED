//
//  LampDetailsTableViewController.swift
//  CityOS-LED
//
//  Created by Said Sikira on 5/7/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import CoreCityOS
import RxSwift

class LampDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var lamp: DeviceType!
    var viewModel: LampDetailsViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(lamp != nil, "Lamp property not set")
        assert(lamp.deviceData.deviceID != "", "set lamp id")
        viewModel = LampDetailsViewModel(lamp: lamp)
        
        viewModel.lampData.debug("details lamp probe")
            .bindTo(tableView.rx_itemsWithCellIdentifier("detailCell", cellType: ObservableTableViewCell.self)) {
                index, data, cell in
                cell.viewModel.title = data.type.dataIdentifier
                cell.viewModel.image = data.blueIcon
                cell.viewModel.rightTitle = "\(data.currentDataPoint?.value ?? 0.0)"
                
        }.addDisposableTo(disposeBag)
//        tableView.rowHeight = 60
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
