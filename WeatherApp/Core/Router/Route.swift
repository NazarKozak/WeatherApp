//
//  Route.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation
import SwiftUI

enum Route: Equatable {
    case home
}

extension Route {
    var hidesBackButton: Bool {
        true
    }

    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case .home:
            HomeView()
        }
    }
}
