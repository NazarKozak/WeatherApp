//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Injected private var weatherApiService: WeatherAPIService

    @Published var searchInput: String = ""
    @Published var weather: Weather?
    @Published var locations: [WeatherLocation] = []
    @Published var isLoading: Bool = false
    @Published var error: String?

    private var searchTask: Task<Void, Never>?
    private var debounceWorkItem: DispatchWorkItem?

    init() {
        self._weather = Published(initialValue: DefaultsHelper.lastWeather)
    }

    @MainActor
    func search() {
        self.isLoading = false
        debounceWorkItem?.cancel()

        guard searchInput.count >= 3 else {
            self.locations = []
            return
        }

        let workItem = DispatchWorkItem { [weak self] in
            self?.performSearch()
        }
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
    }

    private func performSearch() {
        searchTask?.cancel()

        searchTask = Task { @MainActor in
            self.isLoading = true

            let result = await weatherApiService.search(searchInput)
            switch result {
            case let .success(items):
                self.locations = items
            case .failure(let error):
                if let urlError = error as? URLError, urlError.code == .cancelled {
                    return
                }

                logger.error("Failed to load locations: \(error)")
                self.error = error.localizedDescription
            }

            self.isLoading = false
        }
    }
}
