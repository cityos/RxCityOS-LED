//
//  MapViewController.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/18/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var annotations: [MKAnnotation]?
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        
        let doneBarButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(dismissViewController))
        doneBarButton.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], forState: UIControlState.Normal)
        navigationItem.rightBarButtonItem = doneBarButton
        
        mapView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let annotations = annotations {
            mapView.showAnnotations(annotations, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissViewController() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController: MKMapViewDelegate {
    
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
