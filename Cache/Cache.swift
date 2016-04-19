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

/** 
 Cache class is used to offload Realm caching to background threads
 and return results on main thread
*/
public final class Cache {
    
    /// Singleton Cache object
    public static var sharedCache = Cache()
    
    /**
        Executes block of code on background thread using `dispatch_async` GCD call
     
        - parameter delay: delayed execution on background thread (default is 0.0)
        - parameter background: Block of code to run on background thread
        - parameter completion: Optional block of code that is ran after the execution of background block
            on background thread
    */
    func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            if(background != nil){ background!(); }
            
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if(completion != nil){ completion!(); }
            }
        }
    }
    
    /**
        Saves zones to cache
        
        - parameter zones: array of instances conforming to `ZoneType` protocol
    */
    public func saveZones(zones: [ZoneType]) {
        backgroundThread(background: {
            let realm = try! Realm()
            try! realm.write {
                realm.add(zones.map { $0.realmZone }, update: true)
            }
            }, completion: nil)
    }
    
    /**
     Saves lamps to cache
     
     - parameter lamps: array of instances conforming to `DeviceType` protocol
     */
    public func saveLamps(lamps: [DeviceType]) {
        backgroundThread(background: {
            let realm = try! Realm()
            try! realm.write {
                realm.add(lamps.map { $0.realmLamp }, update: true)
            }
            }, completion: nil)
    }
    
    public func getLamps() -> [DeviceType] {
        let realm = try! Realm()
        
        let lamps = realm.objects(RealmLamp)
        
        return lamps.map { $0 }
    }
}
