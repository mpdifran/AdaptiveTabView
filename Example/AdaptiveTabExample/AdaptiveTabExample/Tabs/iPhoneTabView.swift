//
//  iPhoneTabView.swift
//  AdaptiveTabExample
//
//  Created by Mark DiFranco on 2023-03-11.
//

import SwiftUI
import AdaptiveTabView

extension iPhoneTabView {
    static let identifier = TabIdentifier("iPhoneTabView")
}

struct iPhoneTabView: View, TitleImageProviding {
    let title = "iPhones"
    let systemImageName = "iphone"
    let id = iPhoneTabView.identifier

    private let phones = [
        "iPhone 14 Pro Max",
        "iPhone 13 mini",
        "iPhone 12 Pro",
        "iPhone 11"
    ]

    var body: some View {
        List(phones, id: \.self) { (phone) in
            NavigationLink(phone) {
                ContentView(title: phone)
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct iPhoneTabView_Previews: PreviewProvider {
    static var previews: some View {
        iPhoneTabView()
    }
}
