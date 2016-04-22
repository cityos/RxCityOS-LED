//
//  RealmZone.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/18/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import Foundation
import RealmSwift
import CoreCityOS

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
    
    override public class func primaryKey() -> String {
        return "deviceID"
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
    public let allDevices = List<RealmDeviceID>()
    
    /// Zone name
    dynamic public var name = ""
    
    public var zoneInfo: [String : AnyObject] {
        return [
            UpdateTimestampKey: self.lastEditTimestamp.value ?? 0.0
        ]
    }
    
    override public class func primaryKey() -> String {
        return "zoneID"
    }
    
    // Set ignored properties
    override public static func ignoredProperties() -> [String] {
        return [
            "zoneInfo"
        ]
    }
}

//MARK: ZoneType implementation
extension RealmZone: ZoneType {
    
    public var creationDate: NSDate? {
        if let creationTimestamp = creationTimestamp.value {
            return NSDate(timeIntervalSince1970: creationTimestamp / 1000)
        }
        return nil
    }
    
    public var devices: [DeviceType] {
        return allDevices.map {
            let lamp = RealmLamp()
            lamp.deviceID = $0.deviceID
            return lamp
        }
    }
}