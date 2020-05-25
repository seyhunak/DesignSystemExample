//
//  SectionResponse.swift
//  DesignSystemExample
//
//  Created by SEYHUN AKYÜREK on 24.05.2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation

struct Section: Codable {
    let title, subtitle, text: String
    let columnItems: [ColumnItem]
    let rowItems: [RowItem]
    let layoutItems: [LayoutItem]
    let cardItems: [CardItem]
}

struct CardItem: Codable {
    let url: String
}

struct ColumnItem: Codable {
    let imageUrl: String
    let title, subtitle: String
}

struct LayoutItem: Codable {
    let departureTime, departureAirport, arrivalTime, arrivalAirport: String
}

struct RowItem: Codable {
    let headline, caption: String
}
