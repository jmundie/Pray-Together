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
        
        prayerTextField.delegate = self
        postButton.bindToKeyboard()
        postPrayerLabel.bindToKeyboard()
    }

    @IBAction func postPrayerButtonPressed(_ sender: Any) {
        prayerTextField.endEditing(true)
        postButton.isEnabled = false
        
        let prayersDB = Database.database().reference().child("Prayers")
        
        let messageDictionary = ["sender": Auth.auth().currentUser?.email, "PrayerBody": prayerTextField.text!]
        
        prayersDB.childByAutoId().setValue(messageDictionary) {
            (error, ref) in
            
            if error != nil {
                print(error as Any)
            } else {
                print("prayer saved successfully")
                
                self.performSegue(withIdentifier: "goToPrayerStreamVC", sender: self)
                
            }
            
        }
    }
    
    
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
