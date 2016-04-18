//
//  LampZone.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/15/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import Foundation
import CoreCityOS
import Realm
import RealmSwift
import Cache

public struct LampZone: ZoneType {
    public var creationDate: NSDate? = NSDate()
    public var name: String
    public var zoneID: String
    public var devices: [DeviceType]
    
    public init(name: String, zoneID: String, devices: [DeviceType]) {
        self.name = name
        self.zoneID = zoneID
        self.devices = devices
    }
}

