//
//  NetworkClientMock.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 22.01.2025.
//

import Foundation

class NetworkClientMock: NetworkClient {
    var shouldSucceed = true
    var mockData: Any?

    override func requestData<T>(from endpoint: any Endpoint, keypath: String? = nil) async throws -> T where T : Decodable {
        if !shouldSucceed {
            throw NSError(domain: "MockError", code: 1, userInfo: nil)
        }

        guard let data = mockData as? T else {
            throw NSError(domain: "MockError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid Mock Data"])
        }
        return data
    }

    override func requestData<T>(from endpoint: any Endpoint, keypath: String? = nil) async throws -> T where T : Collection, T : Decodable {
        if !shouldSucceed {
            throw NSError(domain: "MockError", code: 1, userInfo: nil)
        }

        guard let data = mockData as? T else {
            throw NSError(domain: "MockError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid Mock Data"])
        }
        return data
    }
}
