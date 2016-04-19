//
//  RealmLamp.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/17/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import CoreCityOS
import RealmSwift
import CoreCityOS

/// Key used in `deviceInfo` property to define last edit date
internal var UpdateTimestampKey = "update"

/**
    Empty class conforming `LiveDataCollectionType` protocol, used to
    initialize dataCollection protocol requirement property on `RealmLamp` class
*/
internal class RealmDataCollection: LiveDataCollectionType {
    var allReadings: [LiveDataType] = []
    var creationDate: NSDate = NSDate()
    var deviceData: DeviceData = DeviceData(deviceID: "cacheDevice")
}

/// Defines Lamp object that is used for caching
public class RealmLamp: Object {
    
    //MARK: Cache Model
    /// Device ID
    dynamic public var deviceID = ""
    
    /// Device creation date
    let creationTimestamp = RealmOptional<Double>()
    
    /// Last update date
    let lastEditTimestamp = RealmOptional<Double>()
    
    /// Lamp name
    dynamic public var name: String?
    
    /// Latitude
    public let latitude = RealmOptional<Double>()
    
    /// Longitude
    public let longitude = RealmOptional<Double>()
    
    /// Schema ID
    dynamic public var schemaID = ""
    
    //MARK: Protocol requirement properties
    
    public var deviceData = DeviceData(deviceID: "")
    public var dataCollection: LiveDataCollectionType = RealmDataCollection()
    
    //MARK: Model setup and helper functions
    
    // Set the primary key
    override public class func primaryKey() -> String? {
        return "deviceID"
    }
    
    // Set ignored properties
    override public static func ignoredProperties() -> [String] {
        return [
            "deviceData",
            "dataCollection"
        ]
    }
    
    /**
        Call this functions to set the `DeviceType` properites to
        exact values.
     
        This is a workaround for now.
    */
    public func setup() {
        deviceData.deviceID = deviceID
        deviceData.schema = schemaID
        dataCollection.deviceData.schema = schemaID
        
        if let editTimestamp = lastEditTimestamp.value {
            deviceData[UpdateTimestampKey] = editTimestamp
        }
    }
}

//MARK: DeviceType implementation

extension RealmLamp: DeviceType {
    
    public var creationDate: NSDate? {
        if let timestamp = creationTimestamp.value {
            return NSDate(timeIntervalSince1970: timestamp)
        }
        return nil
    }
    
    public var location: DeviceLocation? {
        if let latitude = latitude.value, longitude = longitude.value {
            return DeviceLocation(latitude: latitude, longitude: longitude)
        }
        return nil
    }
}