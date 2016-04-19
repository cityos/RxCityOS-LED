//
//  Serializer.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import Foundation
import CoreCityOS

class Serializer {
    class func serializeDrop(data: NSData) throws -> [DeviceType] {
        var jsonData: [String:AnyObject]!
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            guard let dictionary = json as? [String: AnyObject] else {
                throw SerializerError.InvalidDataParsed(message: "")
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
    
    class func serializeZoneDrop(data: NSData) throws -> [ZoneType] {
        var jsonData: [String:AnyObject]!
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            guard let dictionary = json as? [String: AnyObject] else {
                throw SerializerError.InvalidDataParsed(message: "")
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
            
            var lamps = [DeviceType]()
            for lampID in lampsIDs {
                let lamp = Lamp(lampID: lampID)
                lamps.append(lamp)
            }
            
            let zone = LampZone(name: name, zoneID: zoneID, devices: lamps)
            zones.append(zone)
        }
        
        return zones
    }
    
    class func serializeLampDrop(data: NSData) throws -> [DeviceType] {
        var jsonData: [String:AnyObject]!
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            guard let dictionary = json as? [String: AnyObject] else {
                throw SerializerError.InvalidDataParsed(message: "")
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
            let creationDate = body[i]["creationDate"] as! Double
            let lastEditDate = body[i]["lastEditDate"] as! Double
            
            let lamp = Lamp(lampID: id, schemaID: schema)
            
            lamp.name = name
            lamp.creationDate = NSDate(timeIntervalSince1970: creationDate / 1000)
            lamp.deviceData.deviceInfo = ["update": lastEditDate]
            
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
