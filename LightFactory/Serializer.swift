//
//  Serializer.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import class Foundation.NSJSONSerialization
import CoreCityOS

/**
 These keys are used in serialization process to provide additional
 data about the lamps
 */

/// Last edit timestamp key
public let LightFactoryLastUpdateKey = "update"

/// Lamp zone id key
public let LightFactoryZoneKey = "zone"

/**
 Use serializer class to serialize `NSData` returned from the network request
 to the `CoreCityOS` objects.
 
 `NSData` objects must be returned from the Flowthings API, otherwise Serializer
 isn't going to work.
 */
class Serializer {
    
    /**
     Serializes Flowthings drop from `In` flow to `[DeviceType]` array
     
     - parameter data: `NSData` object used in serialization
     
     - throws: `SerializerError`
     
     - returns: `[DeviceType]` array of instances conforming DeviceType protocol
     */
    class func serializeLiveDrop(data: NSData) throws -> [DeviceType] {
        var jsonData: [String:AnyObject]!
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            guard let dictionary = json as? [String: AnyObject] else {
                throw SerializerError.InvalidDataParsed(message: "Error while parsing the data using NSJSONSerialization")
            }
            jsonData = dictionary
        } catch {
            throw error
        }
        
        guard let body = jsonData["body"] as? [[String:AnyObject]] else {
            throw SerializerError.InvalidDataParsed(message: "Couldn't parse body ")
        }
        
        var dataCollection = [DeviceType]()
        
        for i in 0..<body.count {
            guard let elems = body[i]["elems"] as? [String: AnyObject] else {
                throw SerializerError.InvalidDataParsed(message: "Couldn't parse elems")
            }
            let lampID = elems["0"] as! String
            let schemaID = elems["12"] as! String
            
            let lamp = Lamp(lampID: lampID, schemaID: schemaID)
            
            let jsonKeys = lamp.dataCollection.allReadings.map { $0.jsonKey }
            
            for key in jsonKeys {
                let value = elems[key] as! Double
                let dataPoint = DataPoint(value: value)
                lamp.dataCollection[key]?.addDataPoint(dataPoint)
            }
            dataCollection.append(lamp)
        }
        
        return dataCollection
    }
    
    /**
     Serializes Flowthings drop from `Zone` flow to `[ZoneType]` array
     
     - parameter data: `NSData` object used in serialization
     
     - throws: `SerializerError`
     
     - returns: `[ZoneType]` array of instances conforming ZoneType protocol
     */
    class func serializeZoneDrop(data: NSData) throws -> [ZoneType] {
        var jsonData: [String:AnyObject]!
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            guard let dictionary = json as? [String: AnyObject] else {
                throw SerializerError.InvalidDataParsed(message: "Error while parsing the data using NSJSONSerialization")
            }
            jsonData = dictionary
        } catch {
            throw error
        }
        
        guard let body = jsonData["body"] as? [[String:AnyObject]] else {
            throw SerializerError.InvalidDataParsed(message: "Couldn't parse body ")
        }
        
        var zones = [ZoneType]()
        
        for i in 0..<body.count {
            guard let elems = body[i]["elems"] as? [String: AnyObject] else {
                throw SerializerError.MissingParameter(parameter: "elems")
            }
            guard let lampsIDs = elems["lamps"] as? [String] else {
                throw SerializerError.MissingParameter(parameter: "lamps")
            }
            
            guard let name = elems["name"] as? String else {
                throw SerializerError.MissingParameter(parameter: "name")
            }
            
            let zoneID = body[i]["id"] as! String
            let creationDate = body[i]["creationDate"] as! Double
            let lastEditDate = body[i]["lastEditDate"] as? Double
            
            var lamps = [DeviceType]()
            for lampID in lampsIDs {
                let lamp = Lamp(lampID: lampID)
                lamps.append(lamp)
            }
            
            var zone = LampZone(name: name, zoneID: zoneID, devices: lamps)
            zone.creationDate = NSDate(timeIntervalSince1970: creationDate / 1000)
            zone.zoneInfo[LightFactoryLastUpdateKey] = lastEditDate ?? 0.0
            
            zones.append(zone)
        }
        
        return zones
    }
    
    /**
     Serializes Flowthings drop from `Lamps` flow to `[DeviceType]` array
     
     - parameter data: `NSData` object used in serialization
     
     - throws: `SerializerError`
     
     - returns: `[DeviceType]` array of instances conforming DeviceType protocol
     */
    class func serializeLampDrop(data: NSData) throws -> [DeviceType] {
        var jsonData: [String:AnyObject]!
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            guard let dictionary = json as? [String: AnyObject] else {
                throw SerializerError.InvalidDataParsed(message: "Error while parsing the data using NSJSONSerialization")
            }
            jsonData = dictionary
        } catch {
            throw error
        }
        
        guard let body = jsonData["body"] as? [[String:AnyObject]] else {
            throw SerializerError.InvalidDataParsed(message: "Couldn't parse body ")
        }
        
        var lamps = [DeviceType]()
        
        for i in 0..<body.count {
            guard let elems = body[i]["elems"] as? [String: AnyObject] else {
                throw SerializerError.MissingParameter(parameter: "elems")
            }
            
            let id = body[i]["id"] as! String
            let name = elems["model"] as? String
            
            let schema = elems["schema"] as! String
            let zoneID = elems["zoneId"] as! String
            
            let creationDate = body[i]["creationDate"] as! Double
            let lastEditDate = body[i]["lastEditDate"] as! Double
            
            let lamp = Lamp(lampID: id, schemaID: schema)
            
            lamp.name = name
            lamp.creationDate = NSDate(timeIntervalSince1970: creationDate / 1000)
            
            lamp.deviceData[LightFactoryLastUpdateKey] = lastEditDate
            lamp.deviceData[LightFactoryZoneKey] = zoneID
            
            if let location = body[i]["location"] as? [String: AnyObject] {
                let latitude = location["lat"] as! Double
                let longitude = location["lon"] as! Double
                lamp.location = DeviceLocation(latitude: latitude, longitude: longitude)
            }
            
            lamps.append(lamp)
        }
        
        return lamps
    }
}
