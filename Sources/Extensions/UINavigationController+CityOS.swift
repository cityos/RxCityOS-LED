//
//  UINavigationController+CityOS.swift
//  CityOS-LED
//
//  Created by Said Sikira on 5/7/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit

extension UINavigationController {
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if self.topViewController is ChartsViewController {
            return .Portrait
        }
        return UIInterfaceOrientationMask.All
    }
}