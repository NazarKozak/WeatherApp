//
//  WeatherSearchItem.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI

struct WeatherSearchItem: View {
    @StateObject private var viewModel: WeatherSearchItemViewModel

    private var onSelect: (Weather) -> Void

    init(location: WeatherLocation, onSelect: @escaping (Weather) -> Void) {
        self.onSelect = onSelect
        self._viewModel = StateObject(wrappedValue: WeatherSearchItemViewModel(location: location))
    }

    var body: some View {
        Group {
            switch viewModel.state {
                case .loading:
                loadingView(viewModel.location)
            case .loaded(let weather):
                loadedView(weather)
                    .onTapGesture {
                        onSelect(weather)
                    }
            case .failed(let error):
                failedView(viewModel.location, error: error)
            }
        }
        .padding(.horizontal, 31)
        .padding(.vertical, 16)
        .background(.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .contentShape(RoundedRectangle(cornerRadius: 16))
    }

    private func loadedView(_ weather: Weather) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(weather.location.name)
                    .font(.custom(.bold, size: 20, relativeTo: .subheadline))
                    .foregroundStyle(.primaryText)
                Text("\(weather.current.temperature)°")
                    .font(.custom(.semiBold, size: 60, relativeTo: .largeTitle))
                    .foregroundStyle(.primaryText)
            }
            Spacer()
            if let url = URL(string: "https:\(weather.current.condition.icon)") {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 67)
                    case .empty:
                        ProgressView()
                            .frame(width: 67, height: 67)
                    default:
                        Image(systemName: "photo.badge.exclamationmark.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 67)
                    }
                }
            }

        }
    }

    private func loadingView(_ location: WeatherLocation) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(location.name)
                    .font(.custom(.semiBold, size: 20, relativeTo: .subheadline))
                    .foregroundStyle(.primaryText)
                ProgressView()
                    .frame(width: 60, height: 60)
            }
            Spacer()
            ProgressView()
                .frame(width: 67, height: 67)
        }
    }

    private func failedView(_ location: WeatherLocation, error: Error) -> some View {
        HStack {
            VStack(spacing: 12) {
                Text(location.name)
                    .font(.custom(.semiBold, size: 20, relativeTo: .subheadline))
                    .foregroundStyle(.primaryText)
                Text("Error: \(error.localizedDescription)")
                    .font(.custom(.semiBold, size: 16, relativeTo: .subheadline))
                    .foregroundStyle(.red)
                    .frame(height: 60)
            }
            Spacer()
            Image(systemName: "photo.badge.exclamationmark.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 67)
        }
    }
}

#Preview {
    WeatherSearchItem(location: .mock, onSelect: { _ in })
}
