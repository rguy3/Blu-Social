//
//  Posts.swift
//  Blu Social
//
//  Created by Blu on 1/16/17.
//  Copyright © 2017 Blu. All rights reserved.
//

import Foundation

class Post {
    private var _ImageUrl: String!
    private var _description: String!
    private var _likes: Int!
    private var _postKey: String!
    
    var ImageUrl: String {
        return _ImageUrl
    }
    
    var description: String {
        return _description
    }
    
    var likes: Int {
        return _likes
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(description: String, ImageUrl: String, likes: Int, postKey: String) {
        self._description = description
        self._ImageUrl = ImageUrl
        self._likes = likes
        self._postKey = postKey
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let description = postData["description"] as? String {
            self._description = description
        }
        
        if let ImageUrl = postData["IMGUrl"] as? String {
            self._ImageUrl = ImageUrl
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
    }
    
}
