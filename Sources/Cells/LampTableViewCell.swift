//
//  LampTableViewCell.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/18/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import CoreCityOS

class LampTableViewCell: UITableViewCell {

    @IBOutlet weak var lampNameLabel: UILabel!
    @IBOutlet weak var zoneNameLabel: UILabel!
    
    var lamp: DeviceType? {
        didSet {
            if let lamp = lamp {
                lampNameLabel.text = lamp.name
                zoneNameLabel.text = lamp.deviceData["zone"] as? String ?? ""
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
