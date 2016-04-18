//
//  DataReadingTableViewCell.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import CoreCityOS

class DataReadingTableViewCell: UITableViewCell {

    @IBOutlet weak var dataTypeImageView: UIImageView!
    @IBOutlet weak var dataTypeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var dataType: LiveDataType? {
        didSet {
            if let dataType = dataType {
                dataTypeLabel.text = dataType.type.dataIdentifier
                var valueString = NSString(format: "%.2f ", dataType.currentDataPoint!.value) as String
                valueString.appendContentsOf(dataType.unitNotation)
                valueLabel.text = valueString
                dataTypeImageView.image = dataType.whiteIcon
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
