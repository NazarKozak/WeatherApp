//
//  DefaultsHelper.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation

class DefaultsHelper {
    private static let defaults = UserDefaults.standard

    static let lastWeatherKey = "lastWeatherKey"

    static func remove(_ key: String) {
        defaults.removeObject(forKey: key)
    }

    static var lastWeather: Weather? {
        get {
            guard let data = defaults.data(forKey: lastWeatherKey) else { return nil }
            do {
                return try JSONDecoder().decode(Weather.self, from: data)
            } catch {
                logger.error("Failed to decode Weather: \(error.localizedDescription)")
                return nil
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                defaults.set(data, forKey: lastWeatherKey)
            } catch {
                logger.error("Failed to encode Weather: \(error.localizedDescription)")
            }
        }
    }
}
