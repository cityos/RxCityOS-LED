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
import Cache

class ZonesTableViewController: UITableViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var zones: [ZoneType]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        mapView.addMapExpandButton()
        mapView.expandButton?.enabled = false
        
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
        
        LightFactory.sharedInstance.retrieveAllLamps {
            lamps, error in
            if error != nil {
                // error
            } else {
                self.mapView.expandButton?.enabled = true
                self.mapView.showAnnotations(lamps!.map {
                    let x = LampLocation(location: $0.location!, name: $0.name!, subtitle: nil)
                    return x
                    }, animated: true)
            }
        }
        
        mapView.expandButton?.addTarget(self, action: #selector(didTapOnMapExpandButton(_:)), forControlEvents: .TouchUpInside)
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

extension ZonesTableViewController {
    func didTapOnMapExpandButton(button: UIButton) {
        let mapViewController = storyboard?.instantiateViewControllerWithIdentifier("mapController") as! MapViewController
        mapViewController.annotations = self.mapView.annotations
        self.presentViewController(UINavigationController(rootViewController: mapViewController), animated: true, completion: nil)
    }
}