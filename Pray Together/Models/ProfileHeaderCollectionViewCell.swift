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
        
        getProfileInfo()
        
    }
    
    func getProfileInfo() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            
            let username = dictionary["username"] as? String
            self.usernameLabel.text = username
            
            guard let bio = dictionary["bio"] as? String else { return }
            self.bioLabel.text = "Bio: \(bio)"
            
            guard let profilePhoto = dictionary["profileImage"] as? String else { return }
            guard let url = URL(string: profilePhoto) else { return }
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
             
                
                guard let pictureData = data else { return }
                guard let image = UIImage(data: pictureData) else { return }
                
                DispatchQueue.main.async {
                    
                    self.profileImage.image = image
                    self.profileImage.layer.cornerRadius = 100/2
                    self.profileImage.layer.masksToBounds = true
                    self.profileImage.layer.borderColor = #colorLiteral(red: 0.5352031589, green: 0.6165366173, blue: 0.6980209947, alpha: 1)
                    self.profileImage.layer.borderWidth = 3
                }
                
                
                
               
                
            }).resume()
        
        }) { (error) in
            print("failed",error)
        }
    
    }
    
  
    
    @IBAction func editProfileButtonPressed(_ sender: Any) {
    }
    
    

}
