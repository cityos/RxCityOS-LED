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
        zone.creationTimestamp.value = creationDate?.timeIntervalSince1970
        zone.lastEditTimestamp.value = zoneInfo[UpdateTimestampKey] as? Double
        zone.name = name
        
        zone.allDevices.appendContentsOf(
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
        realmLamp.schemaID = dataCollection.deviceData.deviceID
        
        realmLamp.name = name
        
        realmLamp.creationTimestamp.value = creationDate?.timeIntervalSince1970
        realmLamp.lastEditTimestamp.value = deviceData[UpdateTimestampKey] as? Double
        
        realmLamp.latitude.value = location?.latitude ?? 0.0
        realmLamp.longitude.value = location?.longitude ?? 0.0
        
        realmLamp.zoneID = deviceData["zone"] as? String
        
        return realmLamp
    }
}