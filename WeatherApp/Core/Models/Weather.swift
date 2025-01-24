//
//  Weather.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation

struct Weather: Codable {
    let location: Location
    let current: Current

    struct Location: Codable {
        let name: String
        let region: String
        let country: String
        let lat: Double
        let lon: Double
        let tzId: String
        let localtimeEpoch: Int
        let localtime: String

        enum CodingKeys: String, CodingKey {
            case name
            case region
            case country
            case lat
            case lon
            case tzId = "tz_id"
            case localtimeEpoch = "localtime_epoch"
            case localtime
        }

        static var mock: Location {
            Location(name: "Mock City",
                     region: "Mock Region",
                     country: "Mock Country",
                     lat: 0,
                     lon: 0,
                     tzId: "Mock TZ",
                     localtimeEpoch: 0,
                     localtime: "Mock Localtime")
        }
    }

    static var mock: Weather {
        Weather(location: .mock, current: .mock)
    }

    struct Current: Codable {
        let lastUpdatedEpoch: Int
        let lastUpdated: String
        let tempC: Double
        let tempF: Double
        let isDay: Int
        let condition: Condition
        let windMph: Double
        let windKph: Double
        let windDegree: Int
        let windDir: String
        let pressureMb: Double
        let pressureIn: Double
        let precipMm: Double
        let precipIn: Double
        let humidity: Int
        let cloud: Int
        let feelslikeC: Double
        let feelslikeF: Double
        let windchillC: Double
        let windchillF: Double
        let heatindexC: Double
        let heatindexF: Double
        let dewpointC: Double
        let dewpointF: Double
        let visKm: Double
        let visMiles: Double
        let uv: Double
        let gustMph: Double
        let gustKph: Double

        // MARK: Custom
        var temperature: Int {
            let locale = Locale.current
            if locale.measurementSystem == .metric {
                return Int(tempC)
            }
            return Int(tempF)
        }

        var feelsLike: Int {
            let locale = Locale.current
            if locale.measurementSystem == .metric {
                return Int(feelslikeC)
            }
            return Int(feelslikeF)
        }

        enum CodingKeys: String, CodingKey {
            case lastUpdatedEpoch = "last_updated_epoch"
            case lastUpdated = "last_updated"
            case tempC = "temp_c"
            case tempF = "temp_f"
            case isDay = "is_day"
            case condition
            case windMph = "wind_mph"
            case windKph = "wind_kph"
            case windDegree = "wind_degree"
            case windDir = "wind_dir"
            case pressureMb = "pressure_mb"
            case pressureIn = "pressure_in"
            case precipMm = "precip_mm"
            case precipIn = "precip_in"
            case humidity
            case cloud
            case feelslikeC = "feelslike_c"
            case feelslikeF = "feelslike_f"
            case windchillC = "windchill_c"
            case windchillF = "windchill_f"
            case heatindexC = "heatindex_c"
            case heatindexF = "heatindex_f"
            case dewpointC = "dewpoint_c"
            case dewpointF = "dewpoint_f"
            case visKm = "vis_km"
            case visMiles = "vis_miles"
            case uv
            case gustMph = "gust_mph"
            case gustKph = "gust_kph"
        }

        static var mock: Current {
            Current(
                lastUpdatedEpoch: 1673923340,
                lastUpdated: "2025-01-17 09:00",
                tempC: 5.4,
                tempF: 41.7,
                isDay: 1,
                condition: Condition.mock,
                windMph: 3.6,
                windKph: 5.8,
                windDegree: 191,
                windDir: "SSW",
                pressureMb: 1036.0,
                pressureIn: 30.59,
                precipMm: 0.0,
                precipIn: 0.0,
                humidity: 87,
                cloud: 75,
                feelslikeC: 4.3,
                feelslikeF: 39.7,
                windchillC: 1.3,
                windchillF: 34.4,
                heatindexC: 2.8,
                heatindexF: 37.1,
                dewpointC: 2.1,
                dewpointF: 35.7,
                visKm: 10.0,
                visMiles: 6.0,
                uv: 0.2,
                gustMph: 6.7,
                gustKph: 10.7
            )
        }

        struct Condition: Codable {
            let text: String
            let icon: String
            let code: Int

            static var mock: Condition {
                Condition(text: "Sunny", icon: "sunny", code: 100)
            }
        }
    }
}

extension Weather: Equatable {
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.location.name == rhs.location.name
    }
}
