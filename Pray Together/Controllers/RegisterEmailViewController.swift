//
//  RegisterEmailViewController.swift
//  Pray Together
//
//  Created by Jason Mundie on 9/30/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import UIKit
import Firebase

class RegisterEmailViewController: UIViewController {

//    OUTLETS
    @IBOutlet weak var registrationEmailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var registrationPasswordTextField: UITextField!
    
    @IBOutlet weak var registerButtonLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        
        Firebase.Auth.auth().createUser(withEmail: registrationEmailTextField.text!, password: registrationPasswordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
                self.registerButtonLabel.text = "Error"
            } else {
                print("registration successful")
                self.registerButtonLabel.text = "SUCCESS"
                self.backButton.isEnabled = false
            
                self.performSegue(withIdentifier: "gotoHome", sender: self)
        }
        
    }
    

}
}
