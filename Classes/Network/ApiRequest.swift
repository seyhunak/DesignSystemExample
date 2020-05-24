//
//  ApiRequest.swift
//  DesignSystemExample
//
//  Created by SEYHUN AKYÜREK on 24.05.2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation

class ApiRequest {
    var method: RequestType = RequestType.POST
    var path: String!
    var parameters: [String : Any]! = [String : Any]()
    var headers : [String : Any]! = [String : Any]()
    var queryItems : [URLQueryItem]! = []

    func request(with baseURL: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        guard let url = components.url else {
                 fatalError("Could not get url")
             }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if(method != RequestType.GET && parameters.count>0) {
            do{
                let postData = try JSONSerialization.data(withJSONObject: parameters as Any, options: [])
                request.httpBody = postData as Data
            }catch _{
                fatalError("No valid parameters found")
            }

        }

        if(headers.count>0) {
                    for (key, value) in headers {
                        let valueinString =  value as! String
                        request.addValue(valueinString, forHTTPHeaderField: key)
                    }

              }

        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("no-cache", forHTTPHeaderField: "cache-control")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
