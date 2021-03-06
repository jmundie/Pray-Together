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
        
        prayerStreamTableView.register(UINib(nibName: "PrayerStreamTableViewCell", bundle: nil), forCellReuseIdentifier: "PrayerStreamCell")
        
        configureTableView ()
        fetchPrayers ()
        
        prayerStreamTableView.separatorStyle = .singleLine
        
        
    }
    
    func configureTableView () {
        prayerStreamTableView.rowHeight = UITableViewAutomaticDimension
        prayerStreamTableView.estimatedRowHeight = 300.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayerArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrayerStreamCell", for: indexPath) as! PrayerStreamTableViewCell
        
        cell.content.text = prayerArray[indexPath.row].prayerContent
        cell.username.text = prayerArray[indexPath.row].senderId.uppercased()
        cell.profileImage.image = UIImage(named: "defaultProfileImage")
        
        return cell
    }
    
    func fetchPrayers () {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let prayersDB = DataService.instance.REF_STREAM
        prayersDB.child(uid).queryOrdered(byChild: "creationDate").observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, Any>
            guard let text = snapshotValue["prayer"] else { return }
            guard let sender = snapshotValue["username"] else { return }
            
            let prayer = Prayers(prayerContent: text as! String, senderId: sender as! String)
            
            self.prayerArray.append(prayer)
            self.prayerStreamTableView.reloadData()
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

