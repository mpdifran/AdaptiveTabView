//
//  TitlImageProviding.swift
//  
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI

/// A protocol to provide information for the tab item / sidebar item.
public protocol TitleImageProviding {
    /// The title for the screen.
    var title: String { get }
    /// The system image to use for the icon for the screen.
    var systemImageName: String { get }
}

extension TitleImageProviding {

    var label: some View { Label(title, systemImage: systemImageName) }
}

// MARK: - Previews

private struct PreviewExampleView: TitleImageProviding {
    let title = "Settings"
    let systemImageName = "person"
}

struct TitleImageProviding_Previews: PreviewProvider {

    static var previews: some View {
        PreviewExampleView().label
    }
}
