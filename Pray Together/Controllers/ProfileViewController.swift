//
//  ProfileViewController.swift
//  Pray Together
//
//  Created by Jason Mundie on 10/4/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
//    OUTLETS
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var prayersLabel: UILabel!
    @IBOutlet weak var numberOfPrayersLabel: UILabel!
    @IBOutlet weak var organizationsLabel: UILabel!
    @IBOutlet weak var numberOfOrganizationsLabel: UILabel!
    @IBOutlet weak var groupsLabel: UILabel!
    @IBOutlet weak var numberOfGroupsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var numberOfFollowersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var numberFollowingLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioContentLabel: UILabel!
    
    @IBOutlet weak var profileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
    }
    
    @IBAction func editProfileButtonPressed(_ sender: Any) {
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
