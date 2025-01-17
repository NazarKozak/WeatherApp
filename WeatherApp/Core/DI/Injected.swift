//
//  Injected.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation

@propertyWrapper
struct Injected<T> {
    private let serviceType: T.Type
    private let container: DIContainer

    init(_ serviceType: T.Type = T.self) {
        self.serviceType = serviceType
        self.container = .shared
    }

    var wrappedValue: T {
        get {
            guard let resolved = container.resolve(serviceType) else {
                fatalError("No registered dependency for \(serviceType)")
            }
            return resolved
        }
        set {
            container.register(serviceType, service: newValue)
        }
    }
}
