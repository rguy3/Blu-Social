//
//  PostCell.swift
//  Blu Social
//
//  Created by Blu on 1/16/17.
//  Copyright © 2017 Blu. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var postDesc: UITextView!
    @IBOutlet weak var postLikes: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func likePost(_ sender: Any) {
    }
    

}
