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
import FirebaseDatabase
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var feedView: UITableView!
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

        feedView.delegate = self
        feedView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in //Observes all the "posts" object in Firebase
            //print("RICH: Here are the Data Services under POSTS \(snapshot.value)")
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] { //Turn values into individual objects
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key //Key of the Dictionary, ex: "aga4fawaw
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                        print("RICH: Amount of posts: \(self.posts.count)")
                    }
                }
            }
            self.feedView.reloadData() //Be sure to reload data
        })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("RICH: \(posts[indexPath.row].description)")
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
//        let post = posts[indexPath.row]
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
//            cell.postDesc.text = post.description
//            cell.postLikes.text = "\(post.likes)"
//            return cell
//        } else {
//            
//        }
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
