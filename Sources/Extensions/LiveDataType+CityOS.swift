//
//  LiveDataType+CityOS.swift
//  CityOS-LED
//
//  Created by Said Sikira on 5/7/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import CoreCityOS

extension LiveDataType {
    var whiteIcon: UIImage {
        return UIImage(named: "data-\(type.dataIdentifier.lowercaseString)-white")!
    }
    
    var blueIcon: UIImage {
        return UIImage(named: "data-\(type.dataIdentifier.lowercaseString)-blue")!
    }
}