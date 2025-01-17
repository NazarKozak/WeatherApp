//
//  BuildConfiguration.swift
//  Sidequest
//
//  Created by Nazar Kozak on 26.07.2024.
//

import Foundation

struct BuildConfiguration {
    let weatherAPIEndpoint: String
    let weatherAPIKey: String

    static let mock = BuildConfiguration(weatherAPIEndpoint: "",
                                         weatherAPIKey: "")
}
