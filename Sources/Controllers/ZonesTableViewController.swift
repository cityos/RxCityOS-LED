//
//  ZonesTableViewController.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import MapKit
import CoreCityOS
import LightFactory

class ZonesTableViewController: UITableViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var zones: [ZoneType]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        mapView.addMapExpandButton()
        
        LightFactory.sharedInstance.retrieveZones {
            zones, error in
            if error != nil {
                // error
            } else {
                self.zones = zones
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let _ = zones {
            return zones!.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("zoneCell", forIndexPath: indexPath) as! ZoneTableViewCell
        
        cell.zoneNameLabel.text = self.zones![indexPath.row].name
        
        return cell
    }
}

extension MKMapView {
    
    var expandButton: UIButton? {
        return subviews.filter { $0.tag == 133 }.first as? UIButton
    }
    
    func addMapExpandButton() {
        let button = UIButton()
        button.tag = 133
        button.setImage(UIImage(named: "map-expand"), forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(button)
        var constraints = [NSLayoutConstraint]()
        constraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:[expand]-10-|", options: [], metrics: nil, views: ["expand": button]))
        constraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:[expand]-10-|", options: [], metrics: nil, views: ["expand": button]))
        constraints.activateConstraints()
    }
}
