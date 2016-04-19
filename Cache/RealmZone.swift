//
//  RealmZone.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/18/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import Foundation
import RealmSwift

/// Used in Realm arrays to describe string device ID
public class RealmDeviceID: Object {
    
    /// Device ID
    dynamic public var deviceID = ""
    
    /// Returns array of `RealmDeviceID` instances from [String] array
    public class func createFromArray(devices: [String]) -> [RealmDeviceID] {
        return devices.map {
            let device = RealmDeviceID()
            device.deviceID = $0
            return device
        }
    }
}

/// Defines Lamp Zone used in Realms
public class RealmZone: Object {
    
    /// Zone ID
    dynamic public var zoneID = ""
    
    /// Device creation date
    let creationTimestamp = RealmOptional<Double>()
    
    /// Last update date
    let lastEditTimestamp = RealmOptional<Double>()
    
    /// Devices array
    public let devices = List<RealmDeviceID>()
    
    /// Zone name
    dynamic public var name = ""
    
    override public class func primaryKey() -> String {
        return "zoneID"
    }
}