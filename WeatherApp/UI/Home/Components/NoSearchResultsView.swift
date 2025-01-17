//
//  NoSearchResultsView.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI

struct NoSearchResultsView: View {
    var body: some View {
        VStack {
            Text("No City Selected")
                .font(.custom(.semiBold, size: 30, relativeTo: .title))
                .lineSpacing(7.5)
            Text("Please Search For A City")
                .font(.custom(.semiBold, size: 15, relativeTo: .body))
                .lineSpacing(3.75)
        }
    }
}

#Preview {
    NoSearchResultsView()
}
