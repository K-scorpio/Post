//
//  PostController.swift
//  Post
//
//  Created by Kevin Hartley on 6/2/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import Foundation

class PostController {
    
    weak var delegate: PostControllerDelegate?
    
    init() {
        fetchPosts()
    }
    
    static let baseUrl = NSURL(string: "https://devmtn-post.firebaseio.com/posts")
    
    static let endpoint = baseUrl?.URLByAppendingPathExtension(".json")
    
    var posts = [Post]() {
        didSet {
            delegate?.postsUpdated(posts)
        }
    }
    
    func fetchPosts(reset reset: Bool = true, completion: ((posts: [Post]) -> Void)? = nil) {
        guard let url = PostController.baseUrl else {
            fatalError("URL optional is nil")
        }
        NetworkController.performRequestWithUrl(url, httpMethod: .Post, completion: { (data, error) in
            let returnedDataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            guard let data = data,
                jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments),
                jsonDictionary = jsonAnyObject as? [String: AnyObject],
                postDictionaries = jsonDictionary["posts"] as? [[String: AnyObject]] else {
                    print("unable to serialize data, \(returnedDataString)")
                    if let completion = completion {
                    completion(posts: [])
                    }
                    return
            }
            let posts = postDictionaries.flatMap{Post (dictionary: $0)}
            let sortedPostByTime = posts.sort{($0.timestamp < $1.timestamp)}
            self.posts = sortedPostByTime
            if let completion = completion {
            completion(posts: posts)
            }
            return
        })
    }
}

protocol PostControllerDelegate: class {
    func postsUpdated(posts: [Post])
}
