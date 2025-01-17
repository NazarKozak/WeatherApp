//
//  WeatherSearchItemViewModel.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation

class WeatherSearchItemViewModel: ObservableObject {
    @Injected private var weatherApiService: WeatherAPIService

    @Published var location: WeatherLocation
    @Published var state: LoadingState = .loading

    private var loadTask: Task<Void, Never>?

    enum LoadingState {
        case loading
        case loaded(Weather)
        case failed(Error)
    }

    init(location: WeatherLocation) {
        self.location = location

        loadWeather()
    }

    func loadWeather() {
        loadTask?.cancel()
        loadTask = Task { @MainActor in
            self.state = .loading

            let result = await weatherApiService.current(location.name)
            switch result {
            case let .success(item):
                self.state = .loaded(item)
            case .failure(let error):
                logger.error("Failed to load locations: \(error)")
                self.state = .failed(error)
            }
        }
    }
}
