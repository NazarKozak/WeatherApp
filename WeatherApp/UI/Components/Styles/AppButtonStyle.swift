//
//  AppButtonStyle.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI

enum AppButtonType {
    case primary
    case secondary
    case desctructive

    var backgroundColor: Color {
        switch self {
        case .primary:
            return .yellow
        case .secondary:
            return .clear
        case .desctructive:
            return .red
        }
    }

    var textColor: Color {
        switch self {
        case .primary, .desctructive:
            return .white
        case .secondary:
            return .secondary
        }
    }
}

struct AppButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    let type: AppButtonType
    var isLoading: Binding<Bool>?

    private var isLoadingEnabled: Bool {
        if let isLoading {
            return isLoading.wrappedValue
        }
        return false
    }

    init(type: AppButtonType,
         isLoading: Binding<Bool>? = nil) {
        self.type = type
        self.isLoading = isLoading
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Spacer()

            if isLoadingEnabled {
                ProgressView()
                    .tint(type.textColor)
                    .frame(width: 24, height: 24, alignment: .center)
            } else {
                configuration.label
                    .foregroundStyle(type.textColor)
                    .font(.body)
            }

            Spacer()
        }
        .frame(height: 56)
        .background(type.backgroundColor.opacity(configuration.isPressed ? 0.35 : 1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .opacity(isEnabled ? 1 : 0.25)
    }
}
