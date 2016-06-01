//
//  Post.swift
//  Post
//
//  Created by Kevin Hartley on 6/1/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import Foundation

class Post {
    let username: String
    let text: String
    let timestamp: NSTimeInterval = NSTimeInterval()
    let identifier: NSUUID = NSUUID()
    
    init?() {
        
    }
}