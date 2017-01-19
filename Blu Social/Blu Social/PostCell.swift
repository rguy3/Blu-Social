//
//  PostCell.swift
//  Blu Social
//
//  Created by Blu on 1/16/17.
//  Copyright © 2017 Blu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var postDesc: UITextView!
    @IBOutlet weak var postLikes: UILabel!
    
    var post: Post!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func likePost(_ sender: Any) {
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.postDesc.text = post.description
        self.postLikes.text = "\(post.likes)"
        
        if img != nil {
            self.postImg.image = img //image already saved to cache
        } else {
            let ref = FIRStorage.storage().reference(forURL: post.ImageUrl) //If not, save to cache
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in //save to data and resize if its too large
                if error != nil { //If this doesn't work
                    print("RICH: Unable to download image from Firebase Storage")
                } else {
                    print("RICH: Image stored in cache succesful!")
                    if let imgData = data { //Saves it to cache
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img //sets cached img of post
                            FeedVC.imageCache.setObject(img, forKey: post.ImageUrl as NSString)
                        }
                    }
                }
            })
        }
        
    }

}
