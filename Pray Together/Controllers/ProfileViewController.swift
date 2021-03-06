//
//  ProfileViewController.swift
//  Pray Together
//
//  Created by Jason Mundie on 10/4/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
//    OUTLETS
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var profileHeader: UICollectionView!
    
    
    var prayerArray : [Prayers] = [Prayers]()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UINib(nibName: "ProfileStreamTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileStreamCell")
        
        profileHeader.delegate = self
        profileHeader.dataSource = self
        profileHeader.register(UINib(nibName: "ProfileHeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileHeaderCollectionViewCell")
        
        retrievePrayers()
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let profileHeader = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileHeaderCollectionViewCell", for: indexPath) as! ProfileHeaderCollectionViewCell
        
        profileHeader.frame = view.frame
        
        return profileHeader
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
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let prayersDB = DataService.instance.REF_STREAM
        prayersDB.child(uid).queryOrdered(byChild: "creationDate").observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, Any>
            guard let text = snapshotValue["prayer"] else { return }
            guard let sender = snapshotValue["username"] else { return }
            
            let prayer = Prayers(prayerContent: text as! String, senderId: sender as! String)
            
            self.prayerArray.append(prayer)
            print(self.prayerArray.count)
            self.profileTableView.reloadData()
            
            
        }
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

