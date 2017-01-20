//
//  FeedVC.swift
//  Blu Social
//
//  Created by Blu on 1/16/17.
//  Copyright © 2017 Blu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var feedView: UITableView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var selectedImage: UIImageView!
    var imageSelected = false
    
    var posts = [Post]()
    var imgpicker: UIImagePickerController!
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache() //cache'd img

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgpicker = UIImagePickerController()
        imgpicker.allowsEditing = true //allows to crop/edit images
        imgpicker.delegate = self
        
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
        //print("RICH: \(posts[indexPath.row].description)")
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            if let img = FeedVC.imageCache.object(forKey: post.ImageUrl as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
               cell.configureCell(post: post, img: nil)
            }
            
            return cell
            
        } else {
            return PostCell()
        }
    }
    
    
    @IBAction func signOutPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID) //removes KEYUID
        try! FIRAuth.auth()?.signOut() //Signs out of firebase
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        self.loadView()
    }
    
    
    @IBAction func cameraBtnPressed(_ sender: Any) {
        present(imgpicker, animated: true, completion: nil)
    }
    
    @IBAction func postButtonTapped(_ sender: Any) {
        guard let caption = captionField.text, caption != "" else { //guard is an if let with multiple ifs
            print("RICH: Caption must be entered!")
            return
        }
        
        guard let img = selectedImage.image, imageSelected == true else { //Way to guard statements
            print("RICH: An image must be selected! \(selectedImage?.image)")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) { //Converts image to image data to send to firebase storage
            
            let imgUid = NSUUID().uuidString //Creates a unique ID
            let metadata = FIRStorageMetadata() //creates a metadata instance
            metadata.contentType = "image/jpeg" //Adds meta data for content type
            
            DataService.ds.REF_STORAGE_IMAGES.child(imgUid).put(imgData, metadata: metadata) { (metadata, error) in //stores data in Firebase
                if error != nil {
                    print("RICH: Unable to upload image to Firebase Storage")
                } else {
                    print("RICH: Stored image successful!")
                    let downloadURL = metadata?.downloadURL()?.absoluteString //url for accessing the data
                }
        }
    }

}
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) { //For camera. Gets rid of controller after picking image
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImage.image = image
            imageSelected = true //if image has been selected
            print("RICH: Image has been placed - \(selectedImage)")
        }  else {
            print("RICH: Image has not been selected properly.")
        }
        imgpicker.dismiss(animated: true, completion: nil)
    }
}
