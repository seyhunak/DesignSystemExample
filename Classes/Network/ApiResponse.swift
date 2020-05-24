//
//  ApiResponse.swift
//  DesignSystemExample
//
//  Created by SEYHUN AKYÜREK on 24.05.2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let data: T?
    var message: String?
    var succeeded: Bool
}
