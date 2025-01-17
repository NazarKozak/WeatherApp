//
//  RouteHandler.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI

@MainActor
final class RouteHandler: ObservableObject {
    @Published internal var navPath = NavigationPath()
    @Published var modalSheetType: SheetType?

    init() {}
}

extension RouteHandler {
    func navigateTo(_ route: Route) {
        navPath.append(route)
    }

    func showSheet(_ type: SheetType) {
        modalSheetType = type
    }

    func hideSheet() {
        modalSheetType = nil
    }

    func dismiss(_ amount: Int = 1) {
        guard amount > 0, navPath.count >= amount else { return }

        navPath.removeLast(amount)
    }

    func popToRoot() {
        navPath = NavigationPath()
    }

    func popTo(_ route: Route) {
        navPath = NavigationPath([route])
    }

    var isAbleToDismiss: Bool {
        navPath.count > 1
    }
}
