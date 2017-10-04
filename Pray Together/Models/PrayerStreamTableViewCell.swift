//
//  PrayerStreamTableViewCell.swift
//  Pray Together
//
//  Created by Jason Mundie on 10/4/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import UIKit

class PrayerStreamTableViewCell: UITableViewCell {
//OUTLETS
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var prayedForIcon: UIImageView!
    @IBOutlet weak var numberOfTimesPrayedFor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
