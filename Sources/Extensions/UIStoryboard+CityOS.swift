//
//  UIStoryboard+CityOS.swift
//  CityOS-LED
//
//  Created by Said Sikira on 5/7/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func initiateViewController<T: UIViewController>(controller: T.Type) -> T {
        return self.instantiateViewControllerWithIdentifier(String(controller)) as! T
    }
}
