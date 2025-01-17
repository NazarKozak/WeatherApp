//
//  Router.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI

@propertyWrapper struct Router: DynamicProperty {
    @EnvironmentObject var router: RouteHandler

    init() {}

    var wrappedValue: RouteHandler {
        router
    }
}
