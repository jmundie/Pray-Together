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
        
        prayerStreamTableView.register(UINib(nibName: "PrayerStreamTableViewCell", bundle: nil), forCellReuseIdentifier: "prayerStreamCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prayerStreamCell", for: indexPath) as! PrayerStreamTableViewCell
        
        cell.content.text = prayerArray[indexPath.row].prayerContent
        cell.username.text = prayerArray[indexPath.row].senderId
        cell.profileImage.image = UIImage(named: "defaultProfileImage")
        cell.numberOfTimesPrayedFor.text = "123"
        cell.prayedForIcon.image = UIImage(named: "person-with-folded-hands_1f64f")
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

