//
//  MKMapView+CityOS.swift
//  CityOS-LED
//
//  Created by Said Sikira on 5/7/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import class MapKit.MKMapView
import UIKit

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
