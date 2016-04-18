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

public typealias LightFactoryCompletionBlock = (
    data: [DeviceType]?,
    error: ErrorType?) -> ()

public final class LightFactory {
    
    public static var sharedInstance = LightFactory()
    
    /// Retrieves data from in flow
    public func retrieveLatestLampData(limit limit: UInt, completion: LightFactoryCompletionBlock) {
        let request = FlowRequest(flow: Flows.In)
        request.filter = "limit=\(limit)&hints=0"
        
        Flowthings.sharedInstance.find(request) {
            response in
            
            if response.error != nil {
                completion(data: nil, error: response.error!)
            } else {
                if let data = response.data {
                    do {
                        let devices = try Serializer.serializeDrop(data)
//                        Cache.sharedCache.saveLampsToRealm(devices)
                        completion(data: devices, error: nil)
                    } catch {
                        completion(data: nil, error: error)
                    }
                    
                }
            }
        }
    }
    
    public func retrieveZones(completion: (zones: [ZoneType]?, error: ErrorType?) -> ()) {
        let request = FlowRequest(flow: Flows.Zones)
        request.filter = "hints=0"
        
        Flowthings.sharedInstance.find(request) {
            response in
            
            if response.error != nil {
                completion(zones: nil, error: response.error!)
            } else {
                if let data = response.data {
                    do {
                        let zones = try Serializer.serializeZoneDrop(data)
                        Cache.sharedCache.saveZones(zones)
                        completion(zones: zones, error: nil)
                    } catch {
                        completion(zones: nil, error: error)
                    }
                }
            }
        }
    }
}


