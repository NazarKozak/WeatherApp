//
//  SheetType.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI

enum SheetType: Identifiable {
    var id: UUID { UUID() }

    case plain(data: SheetPlainData)
    case error(error: String)

    var body: some View {
        SheetView(showsDragIndicator: showsDragIndicator) {
            sheetBody
        }
    }

    @ViewBuilder
    private var sheetBody: some View {
        switch self {
        case let .plain(data):
            SheetPlainView(data: data)
        case let .error(error):
            SheetPlainView(data: .init(
                title: "Error Occured",
                description: error,
                actions: [.init(title: "OK", type: .primary, action: {})]
            ))
        }
    }

    private var showsDragIndicator: Bool {
        true
    }
}

