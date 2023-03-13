//
//  TabIdentifier.swift
//  
//
//  Created by Mark DiFranco on 2023-03-12.
//

import Foundation

// MARK: - TabIdentifier

public struct TabIdentifier: Identifiable, Hashable, Equatable, ExpressibleByStringLiteral {
    public let id: String

    public init(_ id: String) {
        self.id = id
    }

    public init(stringLiteral value: String) {
        id = value
    }
}
