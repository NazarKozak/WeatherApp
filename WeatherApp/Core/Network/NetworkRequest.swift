//
//  NetworkRequest.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Combine
import Foundation

class NetworkRequest: NSObject {
    let baseURL: String
    let endpoint: Endpoint
    let logger: NetworkLogger
    var timeout: TimeInterval?

    let progressPublisher = PassthroughSubject<Progress, Error>()

    init(baseURL: String,
         endpoint: Endpoint,
         logger: NetworkLogger) {
        self.baseURL = baseURL
        self.endpoint = endpoint
        self.logger = logger
    }

    func execute() async throws -> Data {
        guard let urlRequest = buildURLRequest() else {
            throw NetworkError.unableToParseRequest
        }
        logger.log(request: urlRequest)
        let config = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let startTime = Date()
        let (data, response) = try await urlSession.data(for: urlRequest)
        self.logger.log(response: response, data: data, responseTime: Date().timeIntervalSince(startTime).milliseconds)
        if let httpURLResponse = response as? HTTPURLResponse,
           !(200 ... 299 ~= httpURLResponse.statusCode) {
            var error = NetworkError(errorCode: httpURLResponse.statusCode)
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                error.jsonPayload = json
            }
            throw error
        }
        return data
    }

    private func getURLWithParams() -> String {
        let urlString = baseURL + endpoint.path

        guard let params = endpoint.params, let url = URL(string: urlString) else {
            return urlString
        }

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            var queryItems = urlComponents.queryItems ?? [URLQueryItem]()
            params.forEach { param in
                if let array = param.value as? [CustomStringConvertible] {
                    array.forEach {
                        queryItems.append(URLQueryItem(name: "\(param.key)[]", value: "\($0)"))
                    }
                }
                queryItems.append(URLQueryItem(name: param.key, value: "\(param.value)"))
            }
            urlComponents.queryItems = queryItems
            return urlComponents.url?.absoluteString ?? urlString
        }
        return urlString
    }

    private func buildURLRequest() -> URLRequest? {
        var urlString = baseURL + endpoint.path
        if endpoint.method == .get {
            urlString = getURLWithParams()
        }

        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)

        if endpoint.method != .get,
           endpoint.headers?.keys.contains("Content-Type") == false {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        request.httpMethod = endpoint.method.rawValue
        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        if let timeout = timeout {
            request.timeoutInterval = timeout
        }

        if endpoint.method != .get,
           let body = endpoint.body {
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        } else if endpoint.method != .get, let data = endpoint.data {
            request.httpBody = data
        }
        return request
    }
}

extension NetworkRequest: URLSessionTaskDelegate {
    func urlSession(_: URLSession,
                    task _: URLSessionTask,
                    didSendBodyData _: Int64,
                    totalBytesSent: Int64,
                    totalBytesExpectedToSend: Int64)
    {
        let progress = Progress(totalUnitCount: totalBytesExpectedToSend)
        progress.completedUnitCount = totalBytesSent
        progressPublisher.send(progress)
    }
}
