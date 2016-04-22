//
//  ManageLampViewController.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/22/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import CoreCityOS

class ManageLampViewController: UIViewController {
    
    var lamp: DeviceType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(lamp != nil, "Should set the lamp property")
        
        title = "Manage \(lamp.name ?? "lamp")"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
