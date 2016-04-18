//
//  RealmLamp.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/17/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import CoreCityOS
import RealmSwift

/// Defines Lamp object that is used for caching
public class RealmLamp: Object {
    
    /// Device ID
    dynamic public var deviceID = ""
    
    /// Device creation date
    dynamic public var creationDate: NSDate? = NSDate()
    
    /// Latitude
    public let latitude = RealmOptional<Double>()
    
    /// Longitude
    public let longitude = RealmOptional<Double>()
    
    /// Schema ID
    dynamic public var schemaID = ""
    
    // Sets the primary key
    override public class func primaryKey() -> String? {
        return "deviceID"
    }
}