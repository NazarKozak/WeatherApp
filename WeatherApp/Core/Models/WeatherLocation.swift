//
//  WeatherLocation.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation

struct WeatherLocation: Identifiable, Equatable, Codable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case region
        case country
        case lat
        case lon
        case url
    }

    static var mock: WeatherLocation {
        WeatherLocation(id: 1, name: "Mock", region: "Mock", country: "Mock", lat: 0, lon: 0, url: "")
    }
}
