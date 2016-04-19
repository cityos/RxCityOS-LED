//
//  LampsTableViewController.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import MapKit
import CoreCityOS
import LightFactory

class LampsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var zoneID: String?
    var lamps: [DeviceType]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.addMapExpandButton()
        mapView.expandButton?.enabled = false
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.alpha = 0
        
        LightFactory.sharedInstance.retrieveAllLamps {
            lamps, error in
            if let lamps = lamps {
                dispatch_async(dispatch_get_main_queue(), {
                    self.lamps = lamps
                    self.tableView.reloadData()
                    self.mapView.expandButton?.enabled = true
                    self.showAnnotations()
                    
                    UIView.animateWithDuration(0.5) {
                        self.tableView.alpha = 1
                    }
                })
            }
        }
        
        mapView.expandButton?.addTarget(self, action: #selector(didTapOnMapExpandButton(_:)), forControlEvents: .TouchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LampsViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let lamps = lamps {
            return lamps.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lampCell", forIndexPath: indexPath) as! LampTableViewCell
        
        let lamp = self.lamps![indexPath.row]
        cell.lamp = lamp
        cell.zoneNameLabel.text = ""
        
        return cell
    }
}

extension LampsViewController {
    func didTapOnMapExpandButton(button: UIButton) {
        let mapViewController = storyboard?.instantiateViewControllerWithIdentifier("mapController") as! MapViewController
        if let lamps = lamps {
            let annotations: [MKAnnotation] = lamps.map {
                let lampLocation = LampLocation(location: $0.location!, name: $0.name ?? "", subtitle: "")
                return lampLocation
            }
            mapViewController.annotations = annotations
        }
        self.presentViewController(UINavigationController(rootViewController: mapViewController), animated: true, completion: nil)
    }
    
    func showAnnotations() {
        if let lamps = lamps {
            let annotations: [MKAnnotation] = lamps.map {
                let lampLocation = LampLocation(location: $0.location!, name: $0.name ?? "", subtitle: "")
                return lampLocation
            }
            mapView.showAnnotations(annotations, animated: true)
        }
    }
}
