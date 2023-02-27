//
//  TabLayoutView.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI
import SequenceBuilder

struct TabLayoutView<TabContent: Sequence>: View where TabContent.Element: TabContentView {

    @State private var selectedTab: UInt

    private let tabViews: TabContent

    init(
        defaultSelectedTab: UInt,
        @SequenceBuilder _ tabViewBuilder: (AdaptiveTabViewContainerKind) -> TabContent
    ) {
        self._selectedTab = State(initialValue: defaultSelectedTab)
        self.tabViews = tabViewBuilder(.tabView)
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(sequence: tabViews) { (index, tabView) in
                TabNavigationView {
                    tabView
                }
                .tag(index)
            }
        }
    }
}

struct TabLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        TabLayoutView(defaultSelectedTab: 0) { (_) in
            PreviewTitleImageProvidingView()
        }
    }
}
