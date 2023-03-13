//
//  Either+SwiftUI.swift
//  
//
//  Created by Mark DiFranco on 2023-02-25.
//

import SwiftUI
import SequenceBuilder

extension Either: TitleImageProviding where Left: TitleImageProviding, Right: TitleImageProviding {

    public var id: TabIdentifier {
        fold(left: \.id, right: \.id)
    }

    public var title: String {
        fold(left: \.title, right: \.title)
    }

    public var systemImageName: String {
        fold(left: \.systemImageName, right: \.systemImageName)
    }
}
