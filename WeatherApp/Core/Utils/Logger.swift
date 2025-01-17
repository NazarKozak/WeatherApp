//
//  Logger.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation
import OSLog

enum LogLevel: Int {
    case error
    case warning
    case info
    case debug

    var description: String {
        switch self {
        case .error:
            return "\(Date()) ❌ Error"
        case .warning:
            return "\(Date()) ⚠️ Warning"
        case .info:
            return "\(Date()) ℹ️ Info"
        case .debug:
            return "\(Date()) 🤖 Debug"
        }
    }
}

extension os.Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let weatherApp = Logger(subsystem: subsystem, category: "WeatherApp")
}

class WeatherAppLogger {
    var logLevel: LogLevel = .debug

    func error(_ message: String,
               file: String = #fileID,
               function: String = #function) {
        guard logLevel.rawValue >= LogLevel.error.rawValue else { return }
        log(message, .error, file: file, function: function)
    }

    func warning(_ message: String,
                 file: String = #fileID,
                 function: String = #function) {
        guard logLevel.rawValue >= LogLevel.warning.rawValue else { return }
        log(message, .warning, file: file, function: function)
    }

    func info(_ message: String,
              file: String = #fileID,
              function: String = #function) {
        guard logLevel.rawValue >= LogLevel.info.rawValue else { return }
        log(message, .info, file: file, function: function)
    }

    func debug(_ message: String,
               file: String = #fileID,
               function: String = #function) {
        guard logLevel.rawValue >= LogLevel.debug.rawValue else { return }
        log(message, .debug, file: file, function: function)
    }

    private func log(_ message: String,
                     _ level: LogLevel,
                     file: String,
                     function: String) {
        let shortFileName = file.components(separatedBy: "/").last ?? file
        let fullMessage = "\(shortFileName) || \(function) || \(level.description): \(message)"
        logOS(fullMessage, level)
    }

    private func logOS(_ message: String, _ level: LogLevel) {
        switch level {
        case .error:
            os.Logger.weatherApp.error("\(message)")
        case .warning:
            os.Logger.weatherApp.warning("\(message)")
        case .info:
            os.Logger.weatherApp.info("\(message)")
        case .debug:
            os.Logger.weatherApp.debug("\(message)")
        }
    }
}
