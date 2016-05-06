//
//  LampControlTableViewCell.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/23/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit

class LampControlTableViewCell: UITableViewCell {
    @IBOutlet weak var controlImage: UIImageView!
    @IBOutlet weak var controlTitle: UILabel!
    @IBOutlet weak var rightTitleLabel: UILabel!
    
    var controlItem: LampControlAction! {
        didSet {
            assert(controlItem != nil, "Should set controlItem property in LampControlTableViewCell")
            controlImage.image = controlItem.controlImage
            controlTitle.text = controlItem.rawValue
            rightTitleLabel.text = controlItem.defaultValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
