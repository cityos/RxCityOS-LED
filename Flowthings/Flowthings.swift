//
//  Flowthings.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import Foundation

public typealias FlowthingsCompletionBlock = (data: NSData?, error: ErrorType?) -> ()

public class Flowthings {
    public static var sharedInstance = Flowthings()
    
    static var session = NSURLSession.sharedSession()
    
    public func find(request: FlowRequest, completion: FlowthingsCompletionBlock) -> NSURLSessionTask {
        let request = request.createURL("ceco", token: "TWEFiZvO0KtvWMx5p24JvBbFhBA1oDL3")
        
        let task = Flowthings.session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                completion(data: nil, error: error!)
            } else {
                if let data = data {
                    completion(data: data, error: nil)
                }
            }
        }
        
        return task
    }
}