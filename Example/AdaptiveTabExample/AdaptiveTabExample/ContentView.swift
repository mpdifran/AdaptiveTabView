//
//  ContentView.swift
//  AdaptiveTabExample
//
//  Created by Mark DiFranco on 2023-03-12.
//

import SwiftUI

struct ContentView: View {
    let title: String

    var body: some View {
        Text(title)
            .navigationTitle(title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(title: "Hello World")
    }
}
