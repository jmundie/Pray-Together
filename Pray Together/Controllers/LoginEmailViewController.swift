//
//  LoginEmailViewController.swift
//  Pray Together
//
//  Created by Jason Mundie on 9/30/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import UIKit
import Firebase

class LoginEmailViewController: UIViewController {
//   OUTLETS
    
    @IBOutlet weak var loginEmailTextField: UITextField!
    
    @IBOutlet weak var loginPasswordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
   
    @IBOutlet weak var loginButtonLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        Firebase.Auth.auth().signIn(withEmail: loginEmailTextField.text!, password: loginPasswordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
                self.loginButtonLabel.text = "Error"
            } else {
                print("login successful")
                self.loginButtonLabel.text = "SUCCESS"
                self.backButton.isEnabled = false
                
                self.performSegue(withIdentifier: "gotoHomeLogin", sender: self)
            }
            
        }
    }
}
    

