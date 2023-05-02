//
//  SelectedTabTransformer.swift
//  
//
//  Created by Mark DiFranco on 2023-05-02.
//

import SwiftUI

/// A struct meant to hold transformation logic for the selected tab when the ``AdaptiveTabView`` switches between different ``AdaptiveTabViewContainerKind``s.
public struct SelectedTabTransformer {
    /// A closure to use to transform ``TabIdentifier``s between the different ``AdaptiveTabViewContainerKind``s.
    /// - parameter toKind: The container kind that the ``AdaptiveTabView`` will transform into.
    /// - parameter tabIdentifier: The ``TabIdentifier`` currently selected in the previous ``AdaptiveTabViewContainerKind``.
    public let transformer: (_ toKind: AdaptiveTabViewContainerKind, _ tabIdentifier: TabIdentifier) -> TabIdentifier

    public init(transformer: @escaping (AdaptiveTabViewContainerKind, TabIdentifier) -> TabIdentifier) {
        self.transformer = transformer
    }
}

extension SelectedTabTransformer: EnvironmentKey {
    public static var defaultValue = SelectedTabTransformer { (sizeClass, tabIdentifier) in
        return tabIdentifier
    }
}

public extension EnvironmentValues {
    /// An environment value that holds logic for transforming the selected tab in an ``AdaptiveTabView``.
    var selectedTabTransformer: SelectedTabTransformer {
        get {self[SelectedTabTransformer.self]}
        set {self[SelectedTabTransformer.self] = newValue}
    }
}

public extension View {
    /// Provide a transformer for converting the selected tab in an ``AdaptiveTabView`` when switching between ``AdaptiveTabViewContainerKind``s.
    /// - parameter transformer: The transformer to use when converting the selected tab.
    func selectedTabTransformer(_ transformer: SelectedTabTransformer) -> some View {
        environment(\.selectedTabTransformer, transformer)
    }
}
