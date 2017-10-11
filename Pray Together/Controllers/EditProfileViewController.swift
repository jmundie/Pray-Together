//
//  EditProfileViewController.swift
//  Pray Together
//
//  Created by Jason Mundie on 10/8/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase


class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

//    OUTLETS
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var saveButtonLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   
   
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
                 } else {
                print("camera not available")
            }
            
        }))
       
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImage.image = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = originalImage
        }
        
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderColor = #colorLiteral(red: 0.5352031589, green: 0.6165366173, blue: 0.6980209947, alpha: 1)
        profileImage.layer.borderWidth = 3
        
        picker.dismiss(animated: true, completion: nil)
        
        
        guard let image = self.profileImage.image else { return }
        guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
        let filename = NSUUID().uuidString
        
        Storage.storage().reference().child("Profile Images").child(filename).putData(uploadData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Failed to upload profile picture", error)
                return
            }
            
            guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
            print("successfully uploaded profile picture", profileImageUrl)
            
           guard let uid = Auth.auth().currentUser?.uid else { return }
            
            Database.database().reference().child("users").child(uid).updateChildValues(["profileImage" : profileImageUrl])
            
            self.dismiss(animated: true, completion: nil)
        }
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savedButtonPressed(_ sender: Any) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        if bioTextField.text != nil || usernameTextField.text != nil {
            
            Database.database().reference().child("users").child(uid).updateChildValues(["bio" : bioTextField.text]) as? String
            
            Database.database().reference().child("users").child(uid).updateChildValues(["username" : usernameTextField.text]) as? String
            
        } else {
            print("failed to update profile")
        }
        
        dismiss(animated: true, completion: nil)
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
