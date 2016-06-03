//
//  Post.swift
//  Post
//
//  Created by Kevin Hartley on 6/1/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import Foundation

class Post {
    
    private let kText = "text"
    private let kUsername = "username"
    
    var text: String
    var username: String
    var timestamp: NSTimeInterval = NSTimeInterval()
    var identifier: NSUUID = NSUUID()
    
    init(username: String, text: String, timestamp: NSTimeInterval = NSTimeInterval(), identifier: NSUUID = NSUUID()) {
        self.username = username
        self.text = text
        self.timestamp = timestamp
        self.identifier = identifier
    }
    
    init?(dictionary:[String: AnyObject]) {
        guard let text = dictionary[kText] as? String,
        username = dictionary[kUsername] as? String else {
            return nil
        }
        self.text = text
        self.username = username
        
    }
}