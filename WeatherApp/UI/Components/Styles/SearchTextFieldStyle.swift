//
//  SearchTextFieldStyle.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI

struct SearchTextFieldStyle: TextFieldStyle {
    @Binding var isLoading: Bool

    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            configuration
                .foregroundStyle(.secondaryText)
                .font(.custom(.regular, size: 15, relativeTo: .body))
            if isLoading {
                ProgressView()
                    .frame(width: 17.5, height: 17.5)
                    .foregroundColor(.secondaryText)
            } else {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17.5, height: 17.5)
                    .foregroundColor(.secondaryText)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
        .background(.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
