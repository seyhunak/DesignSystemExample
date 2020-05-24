//
//  Exception.swift
//  DesignSystemExample
//
//  Created by SEYHUN AKYÜREK on 24.05.2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation

public enum Exception : LocalizedError {
    case InvalidIntegrationException(message: String)
    public var errorDescription: String? {
        switch self {
        case let .InvalidIntegrationException(message):
            return message
        }
    }
}
