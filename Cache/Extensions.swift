//
//  Extensions.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/18/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import CoreCityOS

extension ZoneType {
    var realmZone: RealmZone {
        let zone = RealmZone()
        zone.zoneID = zoneID
        zone.creationDate = creationDate ?? NSDate()
        zone.name = name
        
        zone.devices.appendContentsOf(
            RealmDeviceID.createFromArray(
                devices.map { $0.deviceData.deviceID }
            )
        )
        
        return zone
    }
}

extension DeviceType {
    
    var realmLamp: RealmLamp {
        let realmLamp = RealmLamp()
        realmLamp.deviceID = deviceData.deviceID
        realmLamp.name = name
        realmLamp.creationDate = creationDate ?? NSDate()
        realmLamp.latitude.value = location?.latitude ?? 0.0
        realmLamp.longitude.value = location?.longitude ?? 0.0
        realmLamp.schemaID = dataCollection.deviceData.deviceID
        return realmLamp
    }
}