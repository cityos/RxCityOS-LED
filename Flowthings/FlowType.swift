//
//  Flow.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import Foundation

public protocol FlowType {
    var flowID: String { get }
}

public enum Flows: FlowType {
    case In
    case Zones
    
    public var flowID: String {
        switch self {
        case In:
            return "f562e8c4f68056d244d594ce6"
        case .Zones:
            return "f562e8cd15bb709218f2aafd1"
        }
    }
}