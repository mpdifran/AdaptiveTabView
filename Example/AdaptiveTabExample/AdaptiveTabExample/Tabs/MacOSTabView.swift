//
//  MacOSTabView.swift
//  AdaptiveTabExample
//
//  Created by Mark DiFranco on 2023-03-11.
//

import SwiftUI
import AdaptiveTabView

extension MacOSTabView {
    static let identifier = TabIdentifier("MacOSTabView")
}

struct MacOSTabView: View, TitleImageProviding {
    let title = "macOS Versions"
    let systemImageName = "laptopcomputer"
    let id = MacOSTabView.identifier

    private let versions = [
        "Ventura",
        "Monterey",
        "Big Sur",
        "Catalina",
        "Mojave"
    ]

    var body: some View {
        List(versions, id: \.self) { (version) in
            NavigationLink(version) {
                ContentView(title: version)
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct FirstTabView_Previews: PreviewProvider {
    static var previews: some View {
        MacOSTabView()
    }
}
