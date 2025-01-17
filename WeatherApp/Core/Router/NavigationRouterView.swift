//
//  NavigationRouterView.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI
import Combine

struct NavigationRouter<Content>: View where Content: View {
    @ObservedObject private var router: RouteHandler
    private var root: () -> Content

    init(root: @escaping () -> Content) {
        self._router = ObservedObject(initialValue: RouteHandler())
        self.root = root
    }

    var body: some View {
        NavigationStack(path: $router.navPath) {
            root()
                .navigationDestination(for: Route.self) { route in
                    route.buildView()
                        .navigationBarBackButtonHidden(true)
                        .toolbarBackground(.hidden)
                        .gesture(router.isAbleToDismiss ? navSwipeBackGesture : nil)
                        .toolbar(content: {
                            if router.isAbleToDismiss {
                                ToolbarItem(placement: .topBarLeading) {
                                    Button {
                                        router.dismiss()
                                    } label: {
                                        Image(systemName: "arrow.left")
                                            .frame(width: 24, height: 24)
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                        })
                }
        }
        .blur(radius: router.modalSheetType != nil ? 1 : 0)
        .preferredColorScheme(.light)
        .sheet(item: $router.modalSheetType) {
            router.modalSheetType = .none
        } content: { sheet in
            sheet.body
        }
        .environmentObject(router)
    }

    private var navSwipeBackGesture: some Gesture {
        DragGesture(minimumDistance: 50)
            .onEnded { val in
                guard val.translation.width > 50 && val.startLocation.x < 50 else { return }

                router.dismiss()
            }
    }
}
