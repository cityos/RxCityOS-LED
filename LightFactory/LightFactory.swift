//
//  LightFactory.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import CoreCityOS
import Flowthings
import Cache
import RxSwift

public typealias LightFactoryCompletionBlock = (
    data: [DeviceType]?,
    error: ErrorType?) -> ()

public final class LightFactory {
    
    public static var sharedInstance = LightFactory()
    
    /// Retrieves data from in flow
    public func retrieveLatestLampData(limit limit: UInt) -> Observable<[DeviceType]> {
        let request = FlowRequest(flow: Flows.In)
        request.filter = "limit=\(limit)&hints=0"
        
        return Observable.create { observer in
            let task = Flowthings.sharedInstance.find(request) {
                response in
                
                if response.error != nil {
                    observer.on(.Error(response.error!))
                } else {
                    if let data = response.data {
                        do {
                            let devices = try Serializer.serializeLiveDrop(data)
                            if devices.count > 0 {
                                observer.on(.Next(devices))
                                observer.on(.Completed)
                            }
                        } catch {
                            observer.on(.Error(error))
                        }
                        
                    }
                }
            }
            task.resume()
            
            return AnonymousDisposable {
                task.cancel()
            }
        }
        
        
    }
    
    public func retrieveZones() -> Observable<[ZoneType]> {
        return Observable.create { observer in
            do {
                let zones = try Cache.sharedCache.getZones()
                if zones.count > 0 {
                    observer.on(.Next(zones))
                }
            } catch {
                observer.on(.Error(error))
            }
            
            let request = FlowRequest(flow: Flows.Zones)
            request.filter = "hints=0"
            
            let task = Flowthings.sharedInstance.find(request) {
                response in
                
                if response.error != nil {
                    observer.on(.Error(response.error!))
                    observer.on(.Completed)
                } else {
                    if let data = response.data {
                        do {
                            let zones = try Serializer.serializeZoneDrop(data)
                            Cache.sharedCache.saveZones(zones)
                            observer.on(.Next(zones))
                            observer.on(.Completed)
                        } catch {
                            observer.on(.Error(error))
                        }
                    }
                }
            }
            
            task.resume()
            
            return AnonymousDisposable {
                task.cancel()
            }
        }
        
    }
    
    public func retrieveLamps(fromZone zoneID: String? = nil) -> Observable<[DeviceType]> {
        return Observable.create { observer in
            
            if let zoneID = zoneID {
                let lamps = Cache.sharedCache.getLamps(forZoneID: zoneID)
                lamps.subscribe(observer)
            } else {
                let lamps = Cache.sharedCache.getLamps()
                lamps.subscribe(observer)
            }
            
            
            let request = FlowRequest(flow: Flows.Lamps)
            var requestFilterString = "limit=100&hints=0&filter=elems.schema IN \(Lamp.validSchemas)"
            if let zoneID = zoneID {
                requestFilterString += " && elems.zoneId == \"\(zoneID)\""
            }
            request.filter = requestFilterString
            
            let task = Flowthings.sharedInstance.find(request) {
                response in
                
                if response.error != nil {
                    observer.on(.Error(response.error!))
                    observer.on(.Completed)
                } else {
                    if let data = response.data {
                        do {
                            let lamps = try Serializer.serializeLampDrop(data)
                            Cache.sharedCache.saveLamps(lamps)
                            observer.on(.Next(lamps))
                            
                        } catch {
                            observer.on(.Error(error))
                        }
                    }
                }
            }
            task.resume()
            
            return AnonymousDisposable {
//                task.cancel()
            }
        }
        
    }
}


