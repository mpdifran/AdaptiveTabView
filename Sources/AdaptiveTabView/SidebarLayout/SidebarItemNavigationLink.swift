//
//  SidebarItemNavigationLink.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI

struct SidebarItemNavigationLink<Content>: View where Content: View, Content: TitleImageProviding {

    let content: Content

    init(
        @ViewBuilder contentBuidler: () -> Content
    ) {
        self.content = contentBuidler()
    }

    var body: some View {
        NavigationLink(destination: content.navigationTitle(content.title)) {
            content.label
        }
    }
}

struct SidebarItemNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        SidebarItemNavigationLink {
            PreviewTitleImageProvidingView()
        }
    }
}
