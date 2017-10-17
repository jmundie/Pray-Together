//
//  SearchUsersViewController.swift
//  Pray Together
//
//  Created by Jason Mundie on 10/16/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import UIKit
import Firebase

class SearchUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    

//    OUTLETS
   
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
            filteredUsers = self.users.filter { (user) -> Bool in
                return user.username.lowercased().contains(searchText.lowercased())
            }
        
        self.searchResultsTableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.register(UINib(nibName: "SearchUsersTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchUsersTableViewCell")
       
        userSearchBar.delegate = self
        
        configureTableView()
        fetchUsers()
        
   
    }
    
    var filteredUsers = [User]()
    var users = [User]()
    fileprivate func fetchUsers() {
        
        
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                guard let userDictionary = value as? [String: Any] else { return }
                
                let user = User(uid: key, dictionary: userDictionary)
                self.users.append(user)
            })
            
            self.users.sort(by: { (u1, u2) -> Bool in
                
                return u1.username.compare(u2.username) == .orderedAscending
            
            })

            self.searchResultsTableView.reloadData()
            
           
        }) { (error) in
            print("Failed to fetch users for search:", error)
        }
    }
    
    func configureTableView () {
        searchResultsTableView.rowHeight = UITableViewAutomaticDimension
        searchResultsTableView.estimatedRowHeight = 75.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchUsersTableViewCell", for: indexPath) as! SearchUsersTableViewCell
        
        cell.user = filteredUsers[indexPath.item]
        
    
        return cell
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
