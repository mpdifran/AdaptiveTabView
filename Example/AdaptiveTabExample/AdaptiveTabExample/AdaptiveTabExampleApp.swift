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
            VStack {
                Text(selectedTab.id)
                AdaptiveTabView(
                    appName: "Example",
                    selectedTab: $selectedTab
                ) { (containerKind) in
                    MacOSTabView()
                    iPhoneTabView()
                    AppleWatchTabView()
                    if containerKind == .tabView {
                        FolderTabView()
                    }
                } defaultDetail: {
                    ContentView(title: "Empty Details")
                } sidebarExtraContent: {
                    SidebarView()
                }
                .selectedTabTransformer(transformer)
                .navigationSplitViewStyle(.automatic)
            }
        }
    }

    let transformer = SelectedTabTransformer { (kind, tabIdentifier) in
        switch kind {
        case .tabView:
            let sharedTabViewIdentifiers = [
                MacOSTabView.identifier,
                iPhoneTabView.identifier,
                AppleWatchTabView.identifier
            ]
            if !sharedTabViewIdentifiers.contains(tabIdentifier) {
                return FolderTabView.identifier
            }
        case .sidebarView:
            break
        }
        return tabIdentifier
    }
}
