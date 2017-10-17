//
//  SearchUsersTableViewCell.swift
//  Pray Together
//
//  Created by Jason Mundie on 10/16/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import UIKit

class SearchUsersTableViewCell: UITableViewCell {
    var user: User? {
        didSet {
            usernameLabel.text = user?.username
            
            guard let profileImageUrl = user?.profileImageUrl else { return }
            
            profileImage?.loadImage(urlString: profileImageUrl)
            
        }
    }
    
    @IBOutlet weak var profileImage: CustomImageView? = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
