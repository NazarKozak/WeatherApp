//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI

let logger = WeatherAppLogger()

@main
struct WeatherAppApp: App {
    init() {
        setupDIContainer()
    }

    var body: some Scene {
        WindowGroup {
            NavigationRouter {
                HomeView()
            }
        }
    }
}

private extension WeatherAppApp {
    func setupDIContainer() {
        if ProcessInfo.processInfo.arguments.contains("UI_TEST_MODE") {
            setupTestDIContainer()
        } else {
            setupMainDIContainer()
        }
    }

    func setupMainDIContainer() {
        let config = AppConfiguration.shared.config
        let networkClient = NetworkClient(baseURL: config.weatherAPIEndpoint)
        DIContainer.shared.register(WeatherAPIService.self, service: WeatherAPIServiceImpl(networkClient: networkClient, apiKey: config.weatherAPIKey))
    }

    // Just to show how to mock DI for test cases
    func setupTestDIContainer() {
        let config = AppConfiguration.shared.config
        let networkClient = NetworkClient(baseURL: config.weatherAPIEndpoint)
        DIContainer.shared.register(WeatherAPIService.self, service: WeatherAPIServiceMock(networkClient: networkClient, apiKey: config.weatherAPIKey))
    }
}
