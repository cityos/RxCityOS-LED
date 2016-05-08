//
//  ReadingsViewModel.swift
//  CityOS-LED
//
//  Created by Said Sikira on 5/6/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import Foundation
import CoreCityOS
import LightFactory
import RxSwift

class ReadingsViewModel {
    
    static let sharedInstance = ReadingsViewModel()
    
    let readings: Observable<[LiveDataType]>
    
    init() {
        readings = LightFactory
            .sharedInstance
            .retrieveLatestLampData(limit: 1)
            .map { $0[0].dataCollection }
            .map { $0.allReadings }
            .asObservable()
    }
}