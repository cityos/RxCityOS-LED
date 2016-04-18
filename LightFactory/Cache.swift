//
//  Cache.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/15/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import Foundation
import CoreCityOS
import Realm
import RealmSwift

public final class Cache {
    
    /// Singleton object
    public static var sharedCache = Cache()
    
    private var realm: Realm!
    
    public init() {
        realm = try! Realm()
    }
    
    func saveLampsToRealm(lamps: [DeviceType]) {
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
        let realm = try! Realm()
        try! realm.write {
            realm.add(lamps.map { $0.realmLamp }, update: true)
        }
        //        })
    }
    
    func saveZonesToRealm(zones: [ZoneType]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let realm = try! Realm()
            do {
                try realm.write {
                    realm.add(zones.map { $0.realmZone }, update: true)
                }
            } catch {
                print(error)
            }
        })
    }
    
    func getLampWithID(lampID: String) {
        
    }
}