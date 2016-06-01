//
//  LampDataCollection.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import CoreCityOS

public class LampDataCollection: LiveDataCollectionType {
    
    //MARK: Properties
    public var deviceData: DeviceData
    public var creationDate: NSDate = NSDate()
    public var allReadings: [LiveDataType] = []
    
    //MARK: Data types definition
    lazy var energy : LiveDataType = {
        var data = LiveData(
            dataType: .Energy,
            jsonKey: "9",
            unitNotation: "Mwh"
        )
        return data
    }()
    
    lazy var temperature : LiveDataType = {
        let data = LiveData(
            dataType: .Temperature,
            jsonKey: "3",
            unitNotation: "°C"
        )
        return data
    }()
    
    lazy var humidity : LiveDataType = {
        let data = LiveData(
            dataType: .Humidity,
            jsonKey: "4",
            unitNotation: "%"
        )
        return data
    }()
    
    lazy var naturalLight : LiveDataType = {
        let data = LiveData(
            dataType: .NaturalLight,
            jsonKey: "7",
            unitNotation: "lux"
        )
        return data
    }()
    
    lazy var carbonDioxide : LiveDataType = {
        let data = LiveData(
            dataType: .CarbonDioxide,
            jsonKey: "6",
            unitNotation: "µg"
        )
        return data
    }()
    
    lazy var pm25 : LiveDataType = {
        let data = LiveData(
            dataType: .ParticulateMatter25,
            jsonKey: "5",
            unitNotation: "µg"
        )
        return data
    }()
    
    lazy var pm10 : LiveDataType = {
        return LiveData(
            dataType: .ParticulateMatter10,
            jsonKey: "11",
            unitNotation: "µg"
        )
    }()
    
    lazy var noise : LiveDataType = {
        let data = LiveData(
            dataType: .Noise,
            jsonKey: "8",
            unitNotation: "db"
        )
        return data
    }()
    
    //MARK: Init methods
    public init(schemaID: String) {
        deviceData = DeviceData(deviceID: schemaID)
        
        allReadings = [
            energy,
            temperature,
            humidity,
            naturalLight,
            carbonDioxide,
            pm25,
            pm10,
            noise
        ]
    }
}
