//
//  Endpoint.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var params: [String: Any]? { get }
    var body: [String: Any]? { get }
    var data: Data? { get }
}
