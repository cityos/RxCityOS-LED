//
//  Extensions.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import Foundation
import UIKit
import CoreCityOS
import class MapKit.MKMapView

extension UIColor {
    class func mainColor() -> UIColor {
        return UIColor(
            red:0,
            green:0.64,
            blue:0.74, alpha:1
        )
    }
}

extension UIFont {
    class func mainFont() -> UIFont {
        return UIFont(name: "Arcon-Regular", size: 20)!
    }
    
    class func mainFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "Arcon-Regular", size: size)!
    }
}

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

extension UINavigationController {
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if self.topViewController is ChartsViewController {
            return .Portrait
        }
        
//        if self.topViewController is LampDetailChartsViewController {
//            return .Portrait
//        }
        
        return UIInterfaceOrientationMask.All
    }
}

extension CollectionType where Generator.Element == NSLayoutConstraint {
    func activateConstraints() {
        NSLayoutConstraint.activateConstraints(self as! [NSLayoutConstraint])
    }
    
    func deactivateConstraints() {
        NSLayoutConstraint.deactivateConstraints(self as! [NSLayoutConstraint])
    }
}

extension UIScrollView {
    enum UIScrollViewError : ErrorType {
        case PageDoesNotExist(page: Int)
    }
    
    var numberOfPages : Int {
        let fullWidth = self.contentSize.width
        let width = self.frame.width
        let pages = Int(fullWidth / width)
        return pages
    }
    
    var currentPage : Int {
        let page = self.contentOffset.x / self.frame.size.width
        return Int(page)
    }
    
    func goToPage(page: Int) throws {
        if page > numberOfPages - 1 {
            throw UIScrollViewError.PageDoesNotExist(page: page)
        }
        
        let x = self.frame.width * CGFloat(page)
        self.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
}

extension LiveDataType {
    var whiteIcon: UIImage {
        return UIImage(named: "data-\(type.dataIdentifier.lowercaseString)-white")!
    }
    
    var blueIcon: UIImage {
        return UIImage(named: "data-\(type.dataIdentifier.lowercaseString)-blue")!
    }
}


extension MKMapView {
    
    var expandButton: UIButton? {
        return subviews.filter { $0.tag == 133 }.first as? UIButton
    }
    
    func addMapExpandButton() {
        let button = UIButton()
        button.tag = 133
        button.setImage(UIImage(named: "map-expand"), forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(button)
        var constraints = [NSLayoutConstraint]()
        constraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:[expand]-10-|", options: [], metrics: nil, views: ["expand": button]))
        constraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:[expand]-10-|", options: [], metrics: nil, views: ["expand": button]))
        constraints.activateConstraints()
    }
}
