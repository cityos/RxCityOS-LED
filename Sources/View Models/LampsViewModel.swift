//
//  LampsViewModel.swift
//  CityOS-LED
//
//  Created by Said Sikira on 5/6/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import Foundation
import RxSwift
import LightFactory
import CoreCityOS

class LampsViewModel {
    var zoneID: String?
    var lamps: Observable<[DeviceType]>
    
    init(zoneID: String? = nil) {
        self.zoneID = zoneID
        lamps = LightFactory
            .sharedInstance
            .retrieveLamps(fromZone: zoneID)
    }
}