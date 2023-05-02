//
//  FolderTabView.swift
//  AdaptiveTabExample
//
//  Created by Mark DiFranco on 2023-05-02.
//

import SwiftUI
import AdaptiveTabView

extension FolderTabView {
    static let identifier = TabIdentifier("FolderTabView")
}

struct FolderTabView: View, TitleImageProviding {
    let title = "Folders"
    let systemImageName = "folder"
    let id = FolderTabView.identifier

    private let identifiers = [1, 2, 3, 4, 5]

    var body: some View {
        List {
            Section {
                ForEach(identifiers, id: \.self) { (identifier) in
                    NavigationLink {
                        ContentView(title: "Folder \(identifier)")
                    } label: {
                        Label("Folder \(identifier)", systemImage: "folder")
                    }
                }
            }
        }
    }
}

struct FolderTabView_Previews: PreviewProvider {
    static var previews: some View {
        FolderTabView()
    }
}
