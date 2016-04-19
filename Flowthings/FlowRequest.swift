//
//  FlowRequestParameter.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import Foundation

public class FlowRequest {
    var flowID: String
    public var start = 0
    public var limit = 20
    public var filter: String?
    
    public init(flow: FlowType) {
        flowID = flow.flowID
    }
    
    public func createURL(account: String, token: String) -> NSURLRequest {
        var urlString = "https://api.flowthings.io/v0.1/\(account)/drop/\(flowID)"
        
        if let filter = filter {
            urlString.appendContentsOf("?\(filter)")
        }
        
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)

        request.HTTPMethod = "GET"
        
        request.addValue(token, forHTTPHeaderField: "X-Auth-Token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}