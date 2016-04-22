//
//  LampLocation.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/17/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import class Foundation.NSObject
import MapKit
import struct CoreLocation.CLLocationCoordinate2D
import class CoreCityOS.DeviceLocation
import protocol CoreCityOS.DeviceType

class LampLocation: NSObject {
    var lamp: DeviceType
    
    init(lamp: DeviceType) {
        self.lamp = lamp
    }
}

extension LampLocation: MKAnnotation {
    var title: String? {
        return lamp.name
    }
    
    var subtitle: String? {
        return nil
    }
    
    var coordinate: CLLocationCoordinate2D {
        return lamp.location!.coordinate
    }
}

extension LampLocation {
    class func annotationView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "lampPin"
        
        if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
            annotationView.enabled = true
            annotationView.canShowCallout = true
            
            let btn = UIButton(type: .DetailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            return annotationView
        }
    }
}
