//
//  UIFont+CityOS.swift
//  CityOS-LED
//
//  Created by Said Sikira on 5/7/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import class UIKit.UIFont
import struct CoreGraphics.CGFloat

extension UIFont {
    class func mainFont() -> UIFont {
        return UIFont(name: "Arcon-Regular", size: 20)!
    }
    
    class func mainFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "Arcon-Regular", size: size)!
    }
}