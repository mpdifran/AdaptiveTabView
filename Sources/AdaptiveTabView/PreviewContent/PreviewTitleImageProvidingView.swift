//
//  PreviewTitleImageProvidingView.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI

/// An internal struct used for SwiftUI Previews.
struct PreviewTitleImageProvidingView: TabContentView {
    let title = "Preview View"
    let systemImageName = "doc.text.image"

    var body: some View {
        NavigationLink {
            Text("Destination")
        } label: {
            Text("Preview Content")
        }
    }
}

struct PreviewTitleImageProvidingView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewTitleImageProvidingView()
    }
}
