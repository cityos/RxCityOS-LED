//
//  ZoneTableViewCell.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import CoreCityOS

class ZoneTableViewCell: UITableViewCell {
    
    var zoneData: [LiveDataCollectionType]?
    
    var zone: ZoneType? {
        didSet {
            zoneNameLabel.text = zone?.name
        }
    }
    
    @IBOutlet weak var zoneNameLabel: UILabel!
    
    @IBOutlet weak var firstReadingImage: UIImageView!
    @IBOutlet weak var firstReadingValueLabel: UILabel!
    
    @IBOutlet weak var secondReadingImage: UIImageView!
    @IBOutlet weak var secondReadingValueLabel: UILabel!
    
    @IBOutlet weak var thirdReadingImage: UIImageView!
    @IBOutlet weak var thirdReadingValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
