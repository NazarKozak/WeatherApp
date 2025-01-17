//
//  SheetView.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI

struct SheetView<Content: View>: View {
    private let content: Content
    private let showsDragIndicator: Bool

    @State private var detentHeight: CGFloat = Constants.Router.minimumSheetHeight

    init(showsDragIndicator: Bool = true, @ViewBuilder content: () -> Content) {
        self.showsDragIndicator = showsDragIndicator
        self.content = content()
    }

    var body: some View {
        content
            .preferredColorScheme(.light)
            .presentationDragIndicator(showsDragIndicator ? .visible : .hidden)
            .presentationDetents([.height(detentHeight)])
            .readHeight()
            .onPreferenceChange(HeightPreferenceKey.self) { height in
                detentHeight = height ?? Constants.Router.minimumSheetHeight
            }
    }
}
