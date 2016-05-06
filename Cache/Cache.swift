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
import RxSwift

public enum CacheError: ErrorType {
    case RealmError(ErrorType)
}

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
    func backgroundThread(background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            if background != nil {
                background!()
            }
            
            if completion == nil {
                return
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    completion!()
                })
            }
        }
    }
    
    /**
     Saves zones to cache
     
     - parameter zones: array of instances conforming to `ZoneType` protocol
     
     */
    public func saveZones(zones: [ZoneType]) {
        backgroundThread {
            do {
                let realm = try Realm()
                
                try realm.write {
                    realm.add(zones.map { $0.realmZone }, update: true)
                }
            } catch {
                print(error)
            }
        }
    }
    
    /**
     Saves lamps to cache
     
     - parameter lamps: array of instances conforming to `DeviceType` protocol
     
     */
    public func saveLamps(lamps: [DeviceType]) {
        backgroundThread {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(lamps.map { $0.realmLamp }, update: true)
                }
            } catch {
                print(error)
            }
            
        }
    }
    
    /**
     Returns all lamps from cache
     
     - throws: Realm error
     
     - returns: Observable<[DeviceType]>
     */
    public func getLamps() throws -> Observable<[DeviceType]> {
        return Observable.create { observer in
            var realm: Realm?
            
            do {
                realm = try Realm()
                let lamps = realm!.objects(RealmLamp)
                observer.on(.Next(lamps.map {$0 as DeviceType }))
            } catch {
                observer.on(.Error(CacheError.RealmError(error)))
            }
            
            return AnonymousDisposable {
                realm?.cancelWrite()
            }
        }
        
    }
    
    
    /**
     Returns single lamp based on the lamp id provided
     
     - parameter lampID: ID of the lamp
     
     - throws: Realm Error
     
     - returns: `DeviceType?` optional instance
     */
    public func getLamp(lampID: String) throws -> DeviceType? {
        do {
            let realm = try Realm()
            let lamp = realm.objectForPrimaryKey(RealmLamp.self, key: lampID)
            return lamp as? DeviceType
        } catch {
            throw CacheError.RealmError(error)
        }
    }
    
    /**
     Returns all zones from cache
     
     - returns: [ZoneType] array of zones
     */
    public func getZones() throws -> [ZoneType] {
        do {
            let realm = try Realm()
            let zones = realm.objects(RealmZone).sorted("lastEditTimestamp")
            //            let lastEdit = zones.sorted("lastEditTimestamp").first?.lastEditTimestamp.value
            //            print(NSDate(timeIntervalSince1970: lastEdit!))
            return zones.map { $0 }
        } catch {
            throw error
        }
    }
    
    /**
        Delete all objects from Realm
     
        - throws: `RealmError`
    */
    internal func deleteAll() throws {
        do {
            let realm = try Realm()
            
            try realm.write{
                realm.deleteAll()
            }
        } catch {
            throw CacheError.RealmError(error)
        }
    }
}
