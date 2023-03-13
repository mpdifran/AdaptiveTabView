//
//  AdaptiveTabExampleApp.swift
//  AdaptiveTabExample
//
//  Created by Mark DiFranco on 2023-03-11.
//

import SwiftUI
import AdaptiveTabView

@main
struct AdaptiveTabExampleApp: App {
    @State private var selectedTab = iPhoneTabView.identifier

    var body: some Scene {
        WindowGroup {
            AdaptiveTabView(
                appName: "Example",
                selectedTab: $selectedTab
            ) { (containerKind) in
                MacOSTabView()
                iPhoneTabView()
                AppleWatchTabView()
            } defaultDetail: {
                ContentView(title: "Empty Details")
            } sidebarExtraContent: {
                SidebarView()
            }
            .navigationSplitViewStyle(.automatic)
        }
    }
}
