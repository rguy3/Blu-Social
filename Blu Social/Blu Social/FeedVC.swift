//
//  FeedVC.swift
//  Blu Social
//
//  Created by Blu on 1/16/17.
//  Copyright © 2017 Blu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID) //removes KEYUID
        try! FIRAuth.auth()?.signOut() //Signs out of firebase
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
    }

}
