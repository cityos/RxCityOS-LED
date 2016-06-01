//
//  LampDetailsViewModel.swift
//  CityOS-LED
//
//  Created by Said Sikira on 5/8/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import Foundation
import CoreCityOS
import LightFactory
import RxSwift

class LampDetailsViewModel {
    let lamp: DeviceType
    
    var lampData: Observable<[LiveDataType]>
    
    init(lamp: DeviceType) {
        self.lamp = lamp
        lampData = LightFactory
            .sharedInstance
            .retrieveLatestLampData(limit: 1, lampID: lamp.deviceData.deviceID)
            .debug()
            .map { $0[0].dataCollection }
            .map { $0.allReadings }
            .asObservable()
    }
}