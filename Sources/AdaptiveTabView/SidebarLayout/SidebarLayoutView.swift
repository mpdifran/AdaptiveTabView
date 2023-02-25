//
//  SidebarLayoutView.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI
import SequenceBuilder

struct SidebarLayoutView<TabContentView: Sequence, SidebarExtraContent: View, DefaultContentView: View, DefaultDetailView: View>: View where TabContentView.Element: View, TabContentView.Element: TitleImageProviding {

    private let appName: String
    private let splitViewKind: AdaptiveTabViewSplitViewKind
    private let tabViewBuilder: (AdaptiveTabViewContainerKind) -> TabContentView
    private let defaultContentView: DefaultContentView
    private let defaultDetailView: DefaultDetailView
    private let sidebarExtraContent: () -> SidebarExtraContent

    init(
        _ appName: String,
        splitViewKind: AdaptiveTabViewSplitViewKind,
        @SequenceBuilder tabViewBuilder: @escaping (AdaptiveTabViewContainerKind) -> TabContentView,
        @ViewBuilder defaultContentBuilder: () -> DefaultContentView,
        @ViewBuilder defaultDetailBuilder: () -> DefaultDetailView,
        @ViewBuilder sidebarExtraContent: @escaping () -> SidebarExtraContent
    ) {
        self.appName = appName
        self.splitViewKind = splitViewKind
        self.tabViewBuilder = tabViewBuilder
        self.defaultContentView = defaultContentBuilder()
        self.defaultDetailView = defaultDetailBuilder()
        self.sidebarExtraContent = sidebarExtraContent
    }

    var body: some View {
        switch splitViewKind {
        case .twoColumn:
            NavigationSplitView {
                SidebarView(appName, tabViewBuilder: tabViewBuilder, sidebarExtraContent: sidebarExtraContent)
            } detail: {
                defaultDetailView
            }
        case .threeColumn:
            NavigationSplitView {
                SidebarView(appName, tabViewBuilder: tabViewBuilder, sidebarExtraContent: sidebarExtraContent)
            } content: {
                defaultContentView
            } detail: {
                defaultDetailView
            }
        }
    }
}

struct SidebarLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarLayoutView("AdaptiveTabView", splitViewKind: .threeColumn) { (_) in
            PreviewTitleImageProvidingView()
        } defaultContentBuilder: {
            Text("Content")
        } defaultDetailBuilder: {
            Text("Detail")
        } sidebarExtraContent: {
            Text("Hello World")
        }

        SidebarLayoutView("AdaptiveTabView", splitViewKind: .twoColumn) { (_) in
            PreviewTitleImageProvidingView()
        } defaultContentBuilder: {
            Text("Content")
        } defaultDetailBuilder: {
            Text("Detail")
        } sidebarExtraContent: {
            Text("Hello World")
        }
    }
}
