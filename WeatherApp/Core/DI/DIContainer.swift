//
//  DIContainer.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation

class DIContainer {
    static let shared = DIContainer()

    // Dictionary to store services
    private var services: [String: Any] = [:]

    // Register a service
    func register<T>(_ type: T.Type, service: T) {
        let key = String(describing: type)
        services[key] = service
    }

    // Resolve a service
    func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        return services[key] as? T
    }
}
