//
//  ProfileStreamTableViewCell.swift
//  Pray Together
//
//  Created by Jason Mundie on 10/6/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import UIKit

class ProfileStreamTableViewCell: UITableViewCell {
    @IBOutlet weak var prayerContentLabel: UILabel!
    @IBOutlet weak var prayedForButton: UIButton!
    @IBOutlet weak var numberOfPrayers: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
