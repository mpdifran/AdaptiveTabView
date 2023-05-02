//
//  AdaptiveTabView.swift
//
//
//  Created by Mark DiFranco on 2023-02-24.
//

import SwiftUI
import SequenceBuilder

// MARK: - Enums

/// The type of container currently being used by the ``AdaptiveTabView``.
public enum AdaptiveTabViewContainerKind {
    /// The content is being displayed in a ``TabView``.
    case tabView

    /// The content is being displayed in a ``NavigationSplitView`` with a sidebar.
    case sidebarView
}

/// The kind of split view to use when in ``AdaptiveTabViewContainerKind.sidebarView``.
public enum AdaptiveTabViewSplitViewKind {
    /// A split view with only 2 columns.
    case twoColumn

    /// A split view with 3 columns
    case threeColumn
}

// MARK: - AdaptiveTabView

/// A container that displays as a ``TabView`` when the horiontal size class is `.compact`, and displays a ``NavigationSplitView`` when
/// it's `.regular`. This allows for simple support of iPhone and iPad screens in one component.
public struct AdaptiveTabView<TabContent: Sequence, SidebarExtraContent: View, DefaultContentView: View, DefaultDetailView: View>: View where TabContent.Element: TabContentView {

    private let appName: String
    private let splitViewKind: AdaptiveTabViewSplitViewKind
    private let tabViewBuilder: (AdaptiveTabViewContainerKind) -> TabContent
    private let defaultContentBuilder: () -> DefaultContentView
    private let defaultDetailBuilder: () -> DefaultDetailView
    private let sidebarExtraContentBuilder: () -> SidebarExtraContent

    @Binding private var selectedTab: TabIdentifier
    @State private var selectedTabViewTab: TabIdentifier
    @State private var selectedSidebarViewTab: TabIdentifier

    @Environment(\.selectedTabTransformer) var selectedTabTransformer

    /// Creates an ``AdaptiveTabView``.
    /// - parameter appName: The name of the app. This appears as the navigation title of the sidebar when the kind
    /// is ``AdaptiveTabViewContainerKind.sidebarView``.
    /// - parameter selectedTab: The identifier of the selected tab in the currently dsisplayed mode.
    /// - parameter splitViewKind: The type of split view to use.
    /// - parameter tabViews: A view builder to provide the views for the tabs. In ``AdaptiveTabViewContainerKind.tabView``, they appear as
    /// tabs within a ``NavigationView``. In ``AdaptiveTabViewContainerKind.sidebarView``, they appear at the top of the sidebar. You can
    /// use the ``AdaptiveTabViewContainerKind`` to conditionally show tab views.
    /// - parameter defaultContent: The default view to use in ``AdaptiveTabViewContainerKind.sidebarView`` in the content panel, before
    /// anything has been selected. This is only used when ``splitViewKind`` is ``AdaptiveTabViewSplitViewKind.threeColumn``.
    /// - parameter defaultDetail: The default view to use in ``AdaptiveTabViewContainerKind.sidebarView`` in the detail panel, before
    /// anything has been selected.
    /// - parameter sidebarExtraContent:A view builder to provide extra content in the ``List`` below the tab views when the kind
    /// is ``AdaptiveTabViewContainerKind.sidebarView``.
    public init(
        appName: String,
        selectedTab: Binding<TabIdentifier>,
        splitViewKind: AdaptiveTabViewSplitViewKind = .threeColumn,
        @SequenceBuilder tabViews: @escaping (AdaptiveTabViewContainerKind) -> TabContent,
        @ViewBuilder defaultContent: @escaping () -> DefaultContentView = { EmptyView() },
        @ViewBuilder defaultDetail: @escaping () -> DefaultDetailView,
        @ViewBuilder sidebarExtraContent: @escaping () -> SidebarExtraContent = { EmptyView() }
    ) {
        self.appName = appName
        self._selectedTab = selectedTab
        self.splitViewKind = splitViewKind
        self.tabViewBuilder = tabViews
        self.defaultContentBuilder = defaultContent
        self.defaultDetailBuilder = defaultDetail
        self.sidebarExtraContentBuilder = sidebarExtraContent

        self._selectedTabViewTab = State(initialValue: selectedTab.wrappedValue)
        self._selectedSidebarViewTab = State(initialValue: selectedTab.wrappedValue)
    }

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    public var body: some View {
        Group {
            switch horizontalSizeClass {
            case .compact:
                TabLayoutView(
                    selectedTab: $selectedTabViewTab,
                    tabViewBuilder
                )
            default:
                SidebarLayoutView(
                    appName,
                    selectedTab: $selectedSidebarViewTab,
                    splitViewKind: splitViewKind,
                    tabViewBuilder: tabViewBuilder,
                    defaultContentBuilder: defaultContentBuilder,
                    defaultDetailBuilder: defaultDetailBuilder,
                    sidebarExtraContent: sidebarExtraContentBuilder
                )
            }
        }
        .onChange(of: horizontalSizeClass) { newValue in
            guard let containerKind = newValue?.containerKind else { return }

            selectedTab = selectedTabTransformer.transformer(containerKind, selectedTab)
            switch containerKind {
            case .tabView:
                selectedTabViewTab = selectedTab
            case .sidebarView:
                selectedSidebarViewTab = selectedTab
            }
        }
        .onChange(of: selectedTab) { newValue in
            switch horizontalSizeClass {
            case .compact:
                guard selectedTabViewTab != newValue else { return }
                selectedTabViewTab = newValue
            default:
                guard selectedSidebarViewTab != newValue else { return }
                selectedSidebarViewTab = newValue
            }
        }
        .onChange(of: selectedTabViewTab) { newValue in
            guard selectedTab != newValue else { return }
            selectedTab = newValue
        }
        .onChange(of: selectedSidebarViewTab) { newValue in
            guard selectedTab != newValue else { return }
            selectedTab = newValue
        }
    }
}

private extension UserInterfaceSizeClass {
    var containerKind: AdaptiveTabViewContainerKind {
        switch self {
        case .compact: return .tabView
        default: return .sidebarView
        }
    }
}

// MARK: - Previews

struct AdaptiveTabView_Previews: PreviewProvider {
    @State static private var selectedTab = TabIdentifier("PreviewTitleImageProvidingView")

    static var previews: some View {
        AdaptiveTabView(appName: "AdaptiveTabView", selectedTab: $selectedTab) { (_) in
            PreviewTitleImageProvidingView()
            PreviewTitleImageProvidingView()
            PreviewTitleImageProvidingView()
        } defaultContent: {
            Text("Content")
        } defaultDetail: {
            Text("Detail")
        } sidebarExtraContent: {
            Text("Hello World")
        }
        .navigationSplitViewStyle(.balanced)
    }
}
