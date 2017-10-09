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
        
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        if registrationEmailTextField.text != nil && registrationPasswordTextField.text != nil && usernameTextField.text != nil {
            AuthService.instance.registerUser(withEmail: self.registrationEmailTextField.text!, andPassword: self.registrationPasswordTextField.text!, andUsername: self.usernameTextField.text!, andProfileImage: "", userCreationComplete: { (success, registrationError) in
                if success {
                    AuthService.instance.loginUser(withEmail: self.registrationEmailTextField.text!, andPassword: self.registrationPasswordTextField.text!, loginComplete: { (success, nil) in
                        self.performSegue(withIdentifier: "gotoHome", sender: self)
                    })
                } else {
                    print(String(describing: registrationError?.localizedDescription))
                }
            })
        }
        
//        Firebase.Auth.auth().createUser(withEmail: registrationEmailTextField.text!, password: registrationPasswordTextField.text!) { (user, error) in
//
//            if error != nil {
//                print(error!)
//                self.registerButtonLabel.text = "Error"
//            } else {
//                print("registration successful")
//                self.registerButtonLabel.text = "SUCCESS"
//                self.backButton.isEnabled = false
//
//                self.performSegue(withIdentifier: "gotoHome", sender: self)
//        }
//
//    }
    

}
}
