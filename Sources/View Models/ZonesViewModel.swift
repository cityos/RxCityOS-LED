//
//  ZonesViewModel.swift
//  CityOS-LED
//
//  Created by Said Sikira on 5/6/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import Foundation
import CoreCityOS
import LightFactory
import RxSwift

class ZonesViewModel {
    
    static var sharedInstance = ZonesViewModel()
    
    var zones: Observable<[ZoneType]>
    var lamps: Observable<[DeviceType]>
    
    init() {
        zones = LightFactory.sharedInstance.retrieveZones()
        lamps = LightFactory.sharedInstance.retrieveLamps()
    }
}