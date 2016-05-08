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
import RxSwift

class LampsViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Class properties
    var zoneID: String?
    var lamps: [DeviceType]?
    var viewModel: LampsViewModel!
    
    let disposeBag = DisposeBag()
    
    //MARK: - View delegate methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LampsViewModel(zoneID: zoneID)
        
        mapView.addMapExpandButton()
        mapView.expandButton?.enabled = false
        mapView.delegate = self
        
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        viewModel.lamps
            .subscribe { [weak self] event in
                if let lamps = event.element {
                    dispatch_async(dispatch_get_main_queue()) {
                        self?.lamps = lamps
                        self?.tableView.reloadData()
                        self?.mapView.expandButton?.enabled = true
                        self?.showAnnotations()
                    }
                }
                
                if let error = event.error {
                    print(error)
                }
            }.addDisposableTo(disposeBag)
        
        tableView.rx_itemSelected.subscribeNext {
            indexPath in
            let detailsController = self.storyboard!.initiateViewController(LampDetailsViewController)
            self.showViewController(detailsController, sender: self)
            }.addDisposableTo(disposeBag)
        
        mapView.expandButton?.addTarget(
            self,
            action: #selector(didTapOnMapExpandButton(_:)),
            forControlEvents: .TouchUpInside
        )
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let currentIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(currentIndexPath, animated: true)
        }
        mapView.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.delegate = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UITableViewDataSource implementation
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

//MARK: - Map utility methods
extension LampsViewController: MKMapViewDelegate {
    func didTapOnMapExpandButton(button: UIButton) {
        let mapViewController = storyboard?.instantiateViewControllerWithIdentifier("mapController") as! MapViewController
        mapViewController.annotations = mapView.annotations
        self.presentViewController(UINavigationController(rootViewController: mapViewController), animated: true, completion: nil)
    }
    
    func showAnnotations() {
        if let lamps = lamps {
            let annotations: [MKAnnotation] = lamps.map {
                LampLocation(lamp: $0)
            }
            mapView.showAnnotations(annotations, animated: false)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        return LampLocation.annotationView(mapView, viewForAnnotation: annotation)
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? LampLocation {
            let manageController = storyboard!.instantiateViewControllerWithIdentifier("manageLampController") as! ManageLampViewController
            manageController.lamp = annotation.lamp
            self.showViewController(manageController, sender: self)
        }
    }
}
