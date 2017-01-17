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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var feedView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        feedView.delegate = self
        feedView.dataSource = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    
    @IBAction func signOutPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID) //removes KEYUID
        try! FIRAuth.auth()?.signOut() //Signs out of firebase
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        self.loadView()
    }

}
