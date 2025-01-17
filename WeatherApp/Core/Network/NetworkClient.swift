//
//  NetworkClient.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Combine
import Foundation

class NetworkClient {
    let baseURL: String
    var timeout: TimeInterval?

    var logLevel: NetworkLogLevel {
        get { return logger.logLevel }
        set { logger.logLevel = newValue }
    }

    private let logger = NetworkLogger()

    init(baseURL: String, timeout: TimeInterval? = nil) {
        self.baseURL = baseURL
        self.timeout = timeout
    }

    func requestData(from endpoint: Endpoint) async throws -> Data {
        return try await request(from: endpoint).execute()
    }

    func requestData<T: Decodable>(from endpoint: Endpoint, keypath: String? = nil) async throws -> T {
        let json: Any = try await requestData(from: endpoint)
        let model: T = try toModel(json, keypath: keypath)
        return model
    }

    func requestData<T: Decodable>(from endpoint: Endpoint, keypath: String? = nil) async throws -> T where T: Collection {
        let json: Any = try await requestData(from: endpoint)
        return try toModel(json, keypath: keypath)
    }

    func requestData(from endpoint: Endpoint) async throws -> Any {
        let req = request(from: endpoint)
        let data = try await req.execute()
        return try JSONSerialization.jsonObject(with: data, options: [])
    }
}

extension NetworkClient {
    private func request(from endpoint: Endpoint) -> NetworkRequest {
        NetworkRequest(baseURL: baseURL,
                       endpoint: endpoint,
                       logger: logger)
    }

    private func toModel<T: Decodable>(_ json: Any, keypath: String? = nil) throws -> T {
        do {
            let jsonObject = resourceData(from: json, keypath: keypath)
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: data)
            return model
        } catch {
            throw error
        }
    }

    private func toModels<T: Decodable>(_ json: Any, keypath: String? = nil) throws -> [T] {
        do {
            guard let array = resourceData(from: json, keypath: keypath) as? [Any] else {
                return [T]()
            }
            return try array.map { jsonObject in
                let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data)
                return model
            }.compactMap { $0 }
        } catch {
            throw error
        }
    }

    private func resourceData(from json: Any, keypath: String?) -> Any {
        if let keypath = keypath, !keypath.isEmpty, let dic = json as? [String: Any], let val = dic[keypath] {
            return val is NSNull ? json : val
        }
        return json
    }
}
