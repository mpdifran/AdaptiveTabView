//
//  SidebarView.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI
import SequenceBuilder

struct SidebarView<TabContent: Sequence, SidebarExtraContent: View>: View where TabContent.Element: TabContentView {

    private let appName: String
    private let tabViewBuilder: (AdaptiveTabViewContainerKind) -> TabContent
    private let sidebarExtraContent: () -> SidebarExtraContent

    init(
        _ appName: String,
        @SequenceBuilder tabViewBuilder: @escaping (AdaptiveTabViewContainerKind) -> TabContent,
        @ViewBuilder sidebarExtraContent: @escaping () -> SidebarExtraContent
    ) {
        self.appName = appName
        self.tabViewBuilder = tabViewBuilder
        self.sidebarExtraContent = sidebarExtraContent
    }

    var body: some View {
        List {
            ForEach(sequence: tabViewBuilder(.sidebarView)) { (index, tabView) in
                SidebarItemNavigationLink {
                    tabView
                }
            }

            sidebarExtraContent()
        }
        .listStyle(.sidebar)
        .navigationTitle(appName)
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SidebarView("AdaptiveTabView") { (_) in
                PreviewTitleImageProvidingView()
            } sidebarExtraContent: {
                Section("Other Content") {
                    Text("Hello World")
                }
            }
        }
    }
}
