//
//  TabLayoutView.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI
import SequenceBuilder

struct TabLayoutView<TabContentView: Sequence>: View where TabContentView.Element: View, TabContentView.Element: TitleImageProviding {

    private let tabViews: TabContentView

    init(
        @SequenceBuilder _ tabViewBuilder: (AdaptiveTabViewContainerKind) -> TabContentView
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
