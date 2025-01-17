//
//  NetworkLogger.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation

enum NetworkLogLevel {
    case off
    case info
    case debug
}

class NetworkLogger {
    var logLevel = NetworkLogLevel.debug

    func log(request: URLRequest) {
        guard logLevel != .off else {
            return
        }
        if let method = request.httpMethod,
           let url = request.url
        {
            print("\(method) '\(url.absoluteString)'")
            logHeaders(request)
            logBody(request)
        }
        if logLevel == .debug {
            logCurl(request)
        }
    }

    func log(response: URLResponse, data: Data, responseTime: Int) {
        guard logLevel != .off else {
            return
        }
        if let response = response as? HTTPURLResponse {
            logStatusCodeAndURL(response)
        }
        if logLevel == .debug {
            print(data.prettyPrinted)
        }
        // Print the response time
        print("Response time: \(responseTime) MS")
    }

    private func logHeaders(_ urlRequest: URLRequest) {
        if let allHTTPHeaderFields = urlRequest.allHTTPHeaderFields {
            for (key, value) in allHTTPHeaderFields {
                print("  \(key) : \(value)")
            }
        }
    }

    private func logBody(_ urlRequest: URLRequest) {
        if let body = urlRequest.httpBody,
           let str = String(data: body, encoding: .utf8)
        {
            print("  HttpBody : \(str)")
        }
    }

    private func logStatusCodeAndURL(_ urlResponse: HTTPURLResponse) {
        if let url = urlResponse.url {
            print("\(urlResponse.statusCode) '\(url.absoluteString)'")
        }
    }

    private func logCurl(_ urlRequest: URLRequest) {
        print(urlRequest.toCurlCommand())
    }
}

extension URLRequest {
    func toCurlCommand() -> String {
        guard let url = url else { return "" }
        var command = ["curl \"\(url.absoluteString)\""]

        if let method = httpMethod, method != "GET", method != "HEAD" {
            command.append("-X \(method)")
        }

        allHTTPHeaderFields?
            .filter { $0.key != "Cookie" }
            .forEach { command.append("-H '\($0.key): \($0.value)'") }

        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        return command.joined(separator: " \\\n\t")
    }
}

extension Data {
    var prettyPrinted: String {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            return String(decoding: jsonData, as: UTF8.self)
        } else {
            print("json data malformed")
            return ""
        }
    }
}
