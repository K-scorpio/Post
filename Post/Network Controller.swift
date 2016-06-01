//
//  Network Controller.swift
//  Post
//
//  Created by Kevin Hartley on 6/1/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import Foundation

class NetworkController {
    
    enum HTTPMethod: String {
        case Post = "POST"
        case Get = "GET"
        case Put = "PUT"
        case Patch = "PATCH"
        case Delete = "DELETE"
    }
    
    static func performRequestWithUrl(url:NSURL, httpMethod: HTTPMethod, urlParameters: [String: String]? = nil, body: NSData? = nil, completion: ((data: NSData?, error: NSError?) -> Void)?) {
        
        let requestUrl = urlFromURLParameters(url, urlParameters: urlParameters)
        
        let request = NSMutableURLRequest(URL: requestUrl)
        request.HTTPMethod = httpMethod.rawValue
        request.HTTPBody = body
        
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            if let completion = completion {
                completion(data: data, error: error)
            }
        }
        dataTask.resume()
    }
    
    static func urlFromURLParameters(url: NSURL, urlParameters: [String: String]?) -> NSURL {
        
        let components = NSURLComponents(URL: url, resolvingAgainstBaseURL: true)
        
        components?.queryItems = urlParameters?.flatMap({NSURLQueryItem(name: $0.0, value: $0.1)})
        
        if let url = components?.URL {
            return url
        } else {
            fatalError("URL optional is nil")
        }
    }
}
    