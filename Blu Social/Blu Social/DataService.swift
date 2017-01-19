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
//URL for your firebase database authentication
//Same as let BASE_URL = ""https://social-media-example-66563.firebaseio.com/"

let STORAGE_URL = FIRStorage.storage().reference()
//URL for your firebase storage
//Same as let STORAGE_URL = "gs://social-media-example-66563.appspot.com

class DataService {
    
    static let ds = DataService()
    
    //Database References
    private var _REF_BASE = BASE_URL
    private var _REF_POSTS = BASE_URL.child("posts")
    private var _REF_USERS = BASE_URL.child("users")
    
    
    //Storage References
    private var _REF_STORAGE_BASE = STORAGE_URL
    private var _REF_STORAGE_IMAGES = STORAGE_URL.child("post-pics")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_STORAGE_BASE: FIRStorageReference {
        return _REF_STORAGE_BASE
    }
    
    var REF_STORAGE_POSTS: FIRStorageReference {
        return _REF_STORAGE_IMAGES
    }
    

    
    func createFirbaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData) //Creates a child and stores the UID. Firebase will store its own ID. This adds value onto what's already there
        //REF_USERS.child(uid).setValue(userData) Wipes out and updates
    }
}
