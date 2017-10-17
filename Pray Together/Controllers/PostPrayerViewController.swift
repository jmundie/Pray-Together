//
//  PostPrayerViewController.swift
//  Pray Together
//
//  Created by Jason Mundie on 10/4/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import UIKit
import Firebase

class PostPrayerViewController: UIViewController {
//OUTLETS
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var prayerTextField: UITextView!
    @IBOutlet weak var postToGroups: UITextField!
    @IBOutlet weak var postToOrganizations: UITextField!
    @IBOutlet weak var facebookLabel: UILabel!
    @IBOutlet weak var facebookSwitch: UISwitch!
    @IBOutlet weak var postButton: UIButton!
    
    @IBOutlet weak var postPrayerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prayerTextField.delegate = self as! UITextViewDelegate
        postButton.bindToKeyboard()
        postPrayerLabel.bindToKeyboard()
        
        getProfileInfo()
    }

    func getProfileInfo() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String : Any] else { return }
  
            guard let profilePhoto = dictionary["profileImage"] as? String else { return }
            guard let url = URL(string: profilePhoto) else { return }
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                guard let pictureData = data else { return }
                guard let image = UIImage(data: pictureData) else { return }
                
                DispatchQueue.main.async {
                    
                    self.profileImage.image = image
                    self.profileImage.layer.cornerRadius = 75/2
                    self.profileImage.layer.masksToBounds = true
                    self.profileImage.layer.borderColor = #colorLiteral(red: 0.5352031589, green: 0.6165366173, blue: 0.6980209947, alpha: 1)
                    self.profileImage.layer.borderWidth = 3
                }
                
                
                
            }).resume()
            
        }) { (error) in
            print("failed",error)
        }
        
        
        
    }
    
    
    @IBAction func postPrayerButtonPressed(_ sender: Any) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child(uid)
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            
            guard let username = dictionary["username"] as? String else { return }
            
        
        
            if self.prayerTextField.text != nil && self.prayerTextField.text != "Post prayer here..." {
            self.postButton.isEnabled = false
                DataService.instance.uploadPost(withMessage: self.prayerTextField.text, forUID: uid, withUsername:username , withGroupKey: nil, withCreationDate: Date().timeIntervalSince1970, sendComplete: { (isComplete) in
                if isComplete {
                    self.postButton.isEnabled = true
                    self.performSegue(withIdentifier: "goHome", sender: self)
                } else {
                    print("error posting")
                }
            })
        }
    }
    )}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PostPrayerViewController: UITextViewDelegate {
    func textViewDidBeginEditing (_ textView: UITextView) {
        prayerTextField.text = ""
    }
}
