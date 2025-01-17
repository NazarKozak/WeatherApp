//
//  WeatherEndpoint.swift
//  Sidequest
//
//  Created by Nazar Kozak on 17.01.2024.
//

import Foundation

enum WeatherEndpoint {
    case current(q: String, apiKey: String)
    case search(q: String, apiKey: String)
}

extension WeatherEndpoint: Endpoint {
    var path: String {
        switch self {
        case .current:
            return "/current.json"
        case .search:
            return "/search.json"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .current, .search:
            return .get
        }
    }

    var headers: [String: String]? {
        nil
    }

    var params: [String: Any]? {
        switch self {
        case let .current(q, apiKey), let .search(q, apiKey):
            return ["key": apiKey, "q": q]
        }
    }

    var body: [String: Any]? {
        nil
    }

    var data: Data? {
        nil
    }
}
