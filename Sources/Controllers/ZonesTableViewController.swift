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
import RxSwift
import RxCocoa

class ZonesTableViewController: UITableViewController {
    
    //MARK: Views
    @IBOutlet weak var mapView: MKMapView!
    
    /// Zones view controller manages
    var zones: [ZoneType]?
    
    let disposeBag = DisposeBag()
    lazy var viewModel = ZonesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        mapView.addMapExpandButton()
        mapView.expandButton?.enabled = false
        mapView.delegate = self
        
        viewModel.zones
            .doOnError {
                error in
                print("ERRRRRRRRRRRRRR")
            }
            .bindTo(tableView.rx_itemsWithCellIdentifier("zoneCell", cellType: ZoneTableViewCell.self)) { row, zone, cell in
                cell.zoneNameLabel.text = zone.name
            }
            .addDisposableTo(disposeBag)
        
        viewModel.lamps
            .subscribe {
                event in
                if let lamps = event.element {
                    self.mapView.expandButton?.enabled = true
                    self.mapView.showAnnotations(lamps.map { LampLocation(lamp: $0) }, animated: false )
                }
                
                if let error = event.error {
                    print(error)
                }
            }.addDisposableTo(disposeBag)
        
        mapView.expandButton?.addTarget(self,
                                        action: #selector(didTapOnMapExpandButton(_:)),
                                        forControlEvents: .TouchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ZonesTableViewController: MKMapViewDelegate {
    func didTapOnMapExpandButton(button: UIButton) {
        let mapViewController = storyboard?.instantiateViewControllerWithIdentifier("mapController") as! MapViewController
        mapViewController.annotations = self.mapView.annotations
        self.presentViewController(
            UINavigationController(rootViewController: mapViewController),
            animated: true,
            completion: nil
        )
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