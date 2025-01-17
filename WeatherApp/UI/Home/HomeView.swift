//
//  HomeView.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI

struct HomeView: View {
    @Router private var router
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack {
            TextField("Search Location", text: $viewModel.searchInput)
                .textFieldStyle(SearchTextFieldStyle(isLoading: $viewModel.isLoading))
                .onChange(of: viewModel.searchInput) {
                    viewModel.search()
                }
                .onChange(of: viewModel.error) {
                    guard let error = viewModel.error else { return }

                    router.showSheet(.error(error: error))
                }
                .padding(.horizontal, 24)

            if !viewModel.locations.isEmpty {
                List(viewModel.locations) { location in
                    WeatherSearchItem(location: location) { weather in
                        DefaultsHelper.lastWeather = weather
                        withAnimation {
                            viewModel.locations = []
                            viewModel.weather = weather
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(EmptyView())
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 20)
                }
                .listStyle(PlainListStyle())
                .listRowInsets(EdgeInsets())
                .scrollIndicators(.hidden)
                .refreshable {
                    viewModel.search()
                }
            } else if let weather = viewModel.weather {
                Spacer()
                WeatherItemView(weather: weather)
                    .padding(.horizontal, 50)
                Spacer()
            } else {
                Spacer()
                NoSearchResultsView()
            }

            Spacer()
        }
        .task {
            if AppConfiguration.shared.config.weatherAPIKey == "REPLACE_WITH_YOUR_KEY" {
                router.showSheet(.error(error: "Please replace WEATHER_API_KEY with your  [WeatherApi](https://www.weatherapi.com/) key in Configuration/Dev.xcconfig and Configuration/Prod.xcconfig."))
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(RouteHandler())
}
