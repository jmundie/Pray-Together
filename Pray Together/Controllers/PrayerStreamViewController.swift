//
//  PrayerStreamViewController.swift
//  Pray Together
//
//  Created by Jason Mundie on 9/30/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import UIKit
import Firebase

class PrayerStreamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var prayerArray : [Prayers] = [Prayers]()
    
//    OUTLETS
    
    @IBOutlet weak var prayerStreamTableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prayerStreamTableView.delegate = self
        prayerStreamTableView.dataSource = self
        
        prayerStreamTableView.register(UINib(nibName: "PrayerStreamTableViewCell", bundle: nil), forCellReuseIdentifier: "Prayer Stream Table View Cell")
        
        configureTableView ()
        retrievePrayers ()
        
        prayerStreamTableView.separatorStyle = .none
        
        
    }
    
    func configureTableView () {
        prayerStreamTableView.rowHeight = UITableViewAutomaticDimension
        prayerStreamTableView.estimatedRowHeight = 300.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Prayer Stream Table View Cell", for: indexPath) as! PrayerStreamTableViewCell
        
        cell.content.text = prayerArray[indexPath.row].prayerContent
        cell.username.text = prayerArray[indexPath.row].senderId
        cell.profileImage.image = UIImage(named: "defaultProfileImage")
        
        
        
        return cell
    }
    
    func retrievePrayers () {
        let prayersDB = Database.database().reference().child("Prayers")
        prayersDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let text = snapshotValue["PrayerBody"]!
            let sender = snapshotValue["sender"]
            
            let prayer = Prayers(prayerContent: text, senderId: sender!)
            
            self.prayerArray.append(prayer)
            self.prayerStreamTableView.reloadData()
            
            self.configureTableView()
            self.prayerStreamTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

