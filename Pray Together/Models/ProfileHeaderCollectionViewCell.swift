//
//  ProfileHeaderCollectionViewCell.swift
//  Pray Together
//
//  Created by Jason Mundie on 10/9/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import UIKit
import Firebase

class ProfileHeaderCollectionViewCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
//    OUTLETS
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var prayersLabel: UILabel!
    @IBOutlet weak var organizationsLabel: UILabel!
    @IBOutlet weak var groupsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        profileImage.layer.cornerRadius = frame.width/2
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderColor = #colorLiteral(red: 0.5352031589, green: 0.6165366173, blue: 0.6980209947, alpha: 1)
        profileImage.layer.borderWidth = 3
        
        usernameLabel.text = Auth.auth().currentUser?.email
        
    }
    
    
    @IBAction func editProfileButtonPressed(_ sender: Any) {
    }
    
    

}