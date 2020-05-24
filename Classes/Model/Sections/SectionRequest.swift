//
//  SectionRequest.swift
//  DesignSystemExample
//
//  Created by SEYHUN AKYÜREK on 24.05.2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation

class SectionRequest {
    var method = RequestType.GET
    var path = "sections"
    var parameters = [String: String]()

    init(name: String) {
        parameters["name"] = name
    }
}
