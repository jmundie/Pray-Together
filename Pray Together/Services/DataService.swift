//
//  DataService.swift
//  Pray Together
//
//  Created by Jason Mundie on 10/7/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_ORGANIZATIONS = DB_BASE.child("organizations")
    private var _REF_STREAM = DB_BASE.child("Prayer Posts")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_ORGANIZATIONS: DatabaseReference {
        return _REF_ORGANIZATIONS
    }
    
    var REF_STREAM: DatabaseReference {
        return _REF_STREAM
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    

    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
        if groupKey != nil {
            REF_GROUPS.child(groupKey!).child("Prayer Body").childByAutoId().updateChildValues(["Prayer Body": message, "sender": uid])
            sendComplete(true)
        } else {
            REF_STREAM.childByAutoId().updateChildValues(["Prayer Body": message, "sender": uid])
            sendComplete(true)
        }
    }
}
