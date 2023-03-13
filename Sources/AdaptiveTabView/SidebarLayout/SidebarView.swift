//
//  SidebarView.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI
import SequenceBuilder

// MARK: - SidebarView

struct SidebarView<TabContent: Sequence, SidebarExtraContent: View>: View where TabContent.Element: TabContentView {

    private let appName: String
    private let selectedTab: Binding<TabIdentifier>?
    private let tabViewBuilder: (AdaptiveTabViewContainerKind) -> TabContent
    private let sidebarExtraContent: () -> SidebarExtraContent
    private let proxySelectedTab: Binding<TabIdentifier?>

    init(
        _ appName: String,
        selectedTab: Binding<TabIdentifier>?,
        @SequenceBuilder tabViewBuilder: @escaping (AdaptiveTabViewContainerKind) -> TabContent,
        @ViewBuilder sidebarExtraContent: @escaping () -> SidebarExtraContent
    ) {
        self.appName = appName
        self.selectedTab = selectedTab
        self.tabViewBuilder = tabViewBuilder
        self.sidebarExtraContent = sidebarExtraContent

        self.proxySelectedTab = Binding {
            selectedTab?.wrappedValue
        } set: { (value, _) in
            if let value {
                selectedTab?.wrappedValue = value
            }
        }
    }

    var body: some View {
        List(selection: proxySelectedTab) {
            ForEach(sequence: tabViewBuilder(.sidebarView)) { (index, tabView) in
                SidebarItemNavigationLink {
                    tabView
                }
                .tag(tabView.id)
            }

            sidebarExtraContent()
        }
        .listStyle(.sidebar)
        .navigationTitle(appName)
    }
}

// MARK: - Previews

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SidebarView("AdaptiveTabView", selectedTab: nil) { (_) in
                PreviewTitleImageProvidingView()
            } sidebarExtraContent: {
                Section("Other Content") {
                    Text("Hello World")
                }
            }
        }
    }
}
