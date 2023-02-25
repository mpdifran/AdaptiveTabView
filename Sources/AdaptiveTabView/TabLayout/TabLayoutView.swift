//
//  TabLayoutView.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI
import SequenceBuilder

struct TabLayoutView<TabContent: Sequence>: View where TabContent.Element: TabContentView {

    private let tabViews: TabContent

    init(
        @SequenceBuilder _ tabViewBuilder: (AdaptiveTabViewContainerKind) -> TabContent
    ) {
        self.tabViews = tabViewBuilder(.tabView)
    }

    var body: some View {
        TabView {
            ForEach(sequence: tabViews) { (index, tabView) in
                TabNavigationView {
                    tabView
                }
            }
        }
    }
}

struct TabLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        TabLayoutView { (_) in
            PreviewTitleImageProvidingView()
        }
    }
}
