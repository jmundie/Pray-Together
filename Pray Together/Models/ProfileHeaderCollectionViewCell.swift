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
        
        getUsername()
        
    }
    
    func getUsername() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value)
            
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            let username = dictionary["username"] as? String
            self.usernameLabel.text = username
            
        }) { (error) in
            print("failed",error)
        }
    
    }
    
    @IBAction func editProfileButtonPressed(_ sender: Any) {
    }
    
    

}
