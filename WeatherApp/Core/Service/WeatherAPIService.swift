//
//  WeatherAPIService.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation

protocol WeatherAPIService {
    var networkClient: NetworkClient { get }
    var apiKey: String { get }

    func current(_ q: String) async -> Result<Weather, Error>
    func search(_ q: String) async -> Result<[WeatherLocation], Error>
}

class WeatherAPIServiceImpl: WeatherAPIService {
    var networkClient: NetworkClient
    var apiKey: String

    init(networkClient: NetworkClient, apiKey: String) {
        self.networkClient = networkClient
        self.apiKey = apiKey
    }

    func current(_ q: String) async -> Result<Weather, any Error> {
        do {
            let endpoint = WeatherEndpoint.current(q: q, apiKey: apiKey)
            let weather: Weather = try await networkClient.requestData(from: endpoint)
            return .success(weather)
        } catch {
            return .failure(error)
        }
    }

    func search(_ q: String) async -> Result<[WeatherLocation], any Error> {
        do {
            let endpoint = WeatherEndpoint.search(q: q, apiKey: apiKey)
            let locations: [WeatherLocation] = try await networkClient.requestData(from: endpoint)
            return .success(locations)
        } catch {
            return .failure(error)
        }
    }
}

class WeatherAPIServiceMock: WeatherAPIService {
    var networkClient: NetworkClient
    var apiKey: String

    init(networkClient: NetworkClient, apiKey: String) {
        self.networkClient = networkClient
        self.apiKey = apiKey
    }

    func current(_ q: String) async -> Result<Weather, any Error> {
        return .success(.mock)
    }

    func search(_ q: String) async -> Result<[WeatherLocation], Error> {
        return .success([.mock])
    }
}
