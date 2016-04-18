//
//  Cache.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/18/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import protocol CoreCityOS.ZoneType
import protocol CoreCityOS.DeviceType
import RealmSwift

/// Cache class is used to offload Realm caching to background threads
/// and return results on main thread
public final class Cache {
    
    /// Singleton Cache object
    public static var sharedCache = Cache()
    
    func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            if(background != nil){ background!(); }
            
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if(completion != nil){ completion!(); }
            }
        }
    }
    
    /// Saves zones to cache
    public func saveZones(zones: [ZoneType]) {
        backgroundThread(background: {
            let realm = try! Realm()
            try! realm.write {
                realm.add(zones.map { $0.realmZone }, update: true)
            }
            }, completion: nil)
    }
    
    /// Saves lamps to cache
    public func saveLamps(lamps: [DeviceType]) {
        backgroundThread(background: {
            let realm = try! Realm()
            try! realm.write {
                realm.add(lamps.map { $0.realmLamp }, update: true)
            }
            }, completion: nil)
    }
}
