//
//  AppConfiguration.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation

final class AppConfiguration {
    let environmentKey = "Environment"

    var config: BuildConfiguration = .mock

    static let shared = AppConfiguration()

    init() {
        do {
            // Get Environments dictionary with values provided from .xcconfig depending on selected build scheme
            let dictionary = try getDictionary(key: environmentKey)
            let weatherAPIKey = try getValue(in: dictionary, for: .weatherAPIKey)
            let weatherAPIEndpoint = try getValue(in: dictionary, for: .weatherAPIEndpoint)
            // Assign environmet values from .xcconfig to the memory, so it will be accessed faster
            config = BuildConfiguration(weatherAPIEndpoint: "https://\(weatherAPIEndpoint)", weatherAPIKey: weatherAPIKey)
        } catch {
            logger.error(error.localizedDescription)
        }
    }

    private enum Key: String {
        case weatherAPIKey = "WEATHER_API_KEY"
        case weatherAPIEndpoint = "WEATHER_API_ENDPOINT"
    }

    private func getDictionary(key: String) throws -> [String: String] {
        guard let dictionary = Bundle.main.object(forInfoDictionaryKey: key) as? [String: String] else {
            throw ConfigurationError.dictionaryNotFound(key)
        }
        return dictionary
    }

    private func getValue(in dictionary: [String: String], for key: Key) throws -> String {
        guard let value = dictionary[key.rawValue] else {
            throw ConfigurationError.valueNotFound(key.rawValue)
        }
        return value
    }
}
