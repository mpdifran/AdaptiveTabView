//
//  TabLayoutView.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI
import SequenceBuilder

struct TabLayoutView<TabContent: Sequence>: View where TabContent.Element: TabContentView {

    private let selectedTab: Binding<TabIdentifier>?
    private let tabViews: TabContent

    init(
        selectedTab: Binding<TabIdentifier>?,
        @SequenceBuilder _ tabViewBuilder: (AdaptiveTabViewContainerKind) -> TabContent
    ) {
        self.selectedTab = selectedTab
        self.tabViews = tabViewBuilder(.tabView)
    }

    var body: some View {
        TabView(selection: selectedTab) {
            ForEach(sequence: tabViews) { (index, tabView) in
                TabNavigationView {
                    tabView
                }
                .tag(tabView.id)
            }
        }
    }
}

struct TabLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        TabLayoutView(selectedTab: .constant("tabIdentifier")) { (_) in
            PreviewTitleImageProvidingView()
        }
    }
}
