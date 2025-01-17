//
//  SheetPlainView.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI

struct SheetPlainData {
    struct SheetAction: Identifiable {
        var id = UUID()
        let title: String
        let type: AppButtonType
        let action: () -> Void
    }

    let title: String
    let description: String?
    let actions: [SheetAction]
}

struct SheetPlainView: View {
    @Router private var router
    let data: SheetPlainData

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text(data.title)
                .font(.title)

            if let description = data.description {
                Text(.init(description))
                    .font(.body)
            }

            ForEach(data.actions) { action in
                Button {
                    action.action()
                    router.hideSheet()
                } label: {
                    Text(action.title)
                }
                .buttonStyle(AppButtonStyle(type: action.type))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
    }
}
