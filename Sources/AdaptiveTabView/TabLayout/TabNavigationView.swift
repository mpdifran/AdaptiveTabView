//
//  TabNavigationView.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI

struct TabNavigationView<Content: TabContentView>: View {

    private let content: Content

    init(@ViewBuilder contentBuidler: () -> Content) {
        self.content = contentBuidler()
    }

    var body: some View {
        NavigationView {
            content
                .navigationTitle(content.title)
        }
        .tabItem {
            content.label
        }
    }
}

struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            TabNavigationView {
                PreviewTitleImageProvidingView()
            }
        }
    }
}
