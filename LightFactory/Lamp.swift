//
//  Lamp.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import CoreCityOS
import RealmSwift
import Cache

public class Lamp: DeviceType {
    public var deviceData: DeviceData
    public var creationDate: NSDate? = NSDate()
    public var location: DeviceLocation?
    public var dataCollection: LiveDataCollectionType
    
    public init(lampID: String, schemaID: String? = nil) {
        deviceData = DeviceData(deviceID: lampID)
        dataCollection = LampDataCollection(schemaID: schemaID ?? "0")
    }
}

extension Lamp {
    var validSchemas: [String] {
        return [
            "bui4:niue:n2u3:meio"
        ]
    }
}