//
//  Api.swift
//  DesignSystemExample
//
//  Created by SEYHUN AKYÜREK on 24.05.2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation

public enum RequestType: String {
    case GET, POST, DELETE, PUSH
}

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum Mode{
    case Debug
    case Live
}

public class Api {
    public static let shared = Api()
    internal  var envMode = Mode.Debug
}
