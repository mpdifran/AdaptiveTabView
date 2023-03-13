//
//  SidebarView.swift
//  AdaptiveTabExample
//
//  Created by Mark DiFranco on 2023-03-13.
//

import SwiftUI
import AdaptiveTabView

struct SidebarView: View {
    let identifiers = [1, 2, 3, 4, 5]

    var body: some View {
        Group {
            Section("Folders") {
                ForEach(identifiers, id: \.self) { (identifier) in
                    NavigationLink {
                        ContentView(title: "Folder \(identifier)")
                    } label: {
                        Label("Folder \(identifier)", systemImage: "folder")
                    }
                    .tag(TabIdentifier("Folder\(identifier)"))
                }
            }
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
