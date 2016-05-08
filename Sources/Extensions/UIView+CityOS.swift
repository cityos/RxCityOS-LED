//
//  UIView+CityOS.swift
//  CityOS-LED
//
//  Created by Said Sikira on 5/7/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit

class Gradient {
    class func mainGradient() -> CAGradientLayer {
        let color2 = UIColor(
            red:0.15,
            green:0.77,
            blue:0.79,
            alpha:1
            ).CGColor
        
        let color1 = UIColor(
            red:0.02,
            green:0.64,
            blue:0.75,
            alpha:1
            ).CGColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            color1,
            color2
        ]
        
        return gradientLayer
    }
}

extension UIView {
    func addGradientAsBackground() {
        let gradient = Gradient.mainGradient()
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, atIndex: 0)
    }
}

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            )
            .instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}