//
//  DataService.swift
//  Blu Social
//
//  Created by Blu on 1/16/17.
//  Copyright © 2017 Blu. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

let BASE_URL = FIRDatabase.database().reference()
//Same as let BASE_URL = ""https://social-media-example-66563.firebaseio.com/"

class DataService {
    
    static let ds = DataService()
    private var _REF_BASE = BASE_URL
    private var _REF_POSTS = BASE_URL.child("posts")
    private var _REF_USERS = BASE_URL.child("users")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    func createFirbaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData) //Creates a child and stores the UID. Firebase will store its own ID. This adds value onto what's already there
        //REF_USERS.child(uid).setValue(userData) Wipes out and updates
    }
}
