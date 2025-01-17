//
//  TimeInterval+Extension.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import Foundation

extension TimeInterval {
    var seconds: Int {
        return Int(self.rounded())
    }

    var milliseconds: Int {
        return Int(self * 1_000)
    }
}
