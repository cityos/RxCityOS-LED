//
//  LampLocation.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/17/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import class Foundation.NSObject
import protocol MapKit.MKAnnotation
import struct CoreLocation.CLLocationCoordinate2D
import class CoreCityOS.DeviceLocation

class LampLocation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var deviceLocation: DeviceLocation
    
    var coordinate: CLLocationCoordinate2D {
        return deviceLocation.coordinate
    }
    
    init(location: DeviceLocation, name: String, subtitle: String?) {
        title = name
        self.subtitle = subtitle
        self.deviceLocation = location
    }
}
