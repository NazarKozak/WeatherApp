//
//  WeatherItemView.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI

struct WeatherItemView: View {
    @State var weather: Weather

    var body: some View {
        VStack(spacing: 24) {
            if let url = URL(string: "https:\(weather.current.condition.icon)") {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 123)
                    case .empty:
                        ProgressView()
                            .frame(width: 123, height: 123)
                    default:
                        Image(systemName: "photo.badge.exclamationmark.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 123)
                    }
                }
            }

            HStack(spacing: 12) {
                Text(weather.location.name)
                    .font(.custom(.bold, size: 30, relativeTo: .subheadline))
                    .foregroundStyle(.primaryText)
                Image(systemName: "location.fill")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(.primaryText)
                    .frame(width: 21, height: 21)
            }

            Text("\(weather.current.temperature)°")
                .font(.custom(.semiBold, size: 70, relativeTo: .largeTitle))
                .foregroundStyle(.primaryText)

            detailsView
                .padding(.top, 12)
        }
    }

    private var detailsView: some View {
        HStack {
            VStack(spacing: 4) {
                Text("Humidity")
                    .font(.custom(.semiBold, size: 12, relativeTo: .caption))
                    .foregroundStyle(.secondaryText)
                Text("\(Int(weather.current.humidity))%")
                    .font(.custom(.semiBold, size: 15, relativeTo: .caption))
                    .foregroundStyle(.detailsText)
            }
            Spacer()
            VStack(spacing: 4) {
                Text("UV")
                    .font(.custom(.semiBold, size: 12, relativeTo: .caption))
                    .foregroundStyle(.secondaryText)
                Text("\(Int(weather.current.uv))")
                    .font(.custom(.semiBold, size: 15, relativeTo: .caption))
                    .foregroundStyle(.detailsText)
            }
            Spacer()
            VStack(spacing: 4) {
                Text("Feels Like")
                    .font(.custom(.semiBold, size: 8, relativeTo: .caption))
                    .foregroundStyle(.secondaryText)
                Text("\(Int(weather.current.feelsLike))°")
                    .font(.custom(.semiBold, size: 15, relativeTo: .caption))
                    .foregroundStyle(.detailsText)
            }
        }
        .padding(16)
        .padding(.trailing, 12)
        .background(.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    WeatherItemView(weather: .mock)
}
