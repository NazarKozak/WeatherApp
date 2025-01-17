//
//  ConfigurationError.swift
//  Sidequest
//
//  Created by Nazar Kozak on 26.07.2024.
//

import Foundation

enum ConfigurationError: Error {
    case environmentNotFound
    case dictionaryNotFound(String)
    case valueNotFound(String)

    var description: String {
        switch self {
        case .environmentNotFound:
            return "Environment setup not configured"
        case let .dictionaryNotFound(key):
            return "Dictionary with key: \(key) not found in Info.plist"
        case let .valueNotFound(key):
            return "The value for key: \(key) not found in .xcconfig"
        }
    }
}
