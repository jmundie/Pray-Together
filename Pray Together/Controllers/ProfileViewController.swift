//
//  ProfileViewController.swift
//  Pray Together
//
//  Created by Jason Mundie on 10/4/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
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
    
    var prayerArray : [Prayers] = [Prayers]()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UINib(nibName: "ProfileStreamTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileStreamCell")
        
        retrievePrayers()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileStreamCell", for: indexPath) as! ProfileStreamTableViewCell
        
        cell.prayerContentLabel.text = prayerArray[indexPath.row].prayerContent
        
        return cell        
    }
    
    func retrievePrayers () {
        let prayersDB = DataService.instance.REF_STREAM
        prayersDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let text = snapshotValue["Prayer Body"]!
            let sender = snapshotValue["sender"]
            
            let prayer = Prayers(prayerContent: text, senderId: sender!)
            
            self.prayerArray.append(prayer)
            self.profileTableView.reloadData()
            
            self.profileTableView.reloadData()
        }
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.usernameLabel.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeViewController
            self.present(welcomeVC, animated: true, completion: nil)
        } catch {
            print("error signing out")
        }
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

