//
//  AppleWatchTabView.swift
//  AdaptiveTabExample
//
//  Created by Mark DiFranco on 2023-03-11.
//

import SwiftUI
import AdaptiveTabView

extension AppleWatchTabView {
    static let identifier = TabIdentifier("AppleWatchTabView")
}

struct AppleWatchTabView: View, TitleImageProviding {
    let title = "Apple Watches"
    let systemImageName = "applewatch"
    let id = AppleWatchTabView.identifier

    private let watches = [
        "Apple Watch SE",
        "Apple Watch Ultra",
        "Apple Watch Series 8",
        "Apple Watch Series 7"
    ]

    var body: some View {
        List(watches, id: \.self) { (watch) in
            NavigationLink(watch) {
                ContentView(title: watch)
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct AppleWatchTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppleWatchTabView()
    }
}
