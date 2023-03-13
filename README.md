# AdaptiveTabView

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmpdifran%2FAdaptiveTabView%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/mpdifran/AdaptiveTabView)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmpdifran%2FAdaptiveTabView%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/mpdifran/AdaptiveTabView)

An adaptive SwiftUI container that switches between [TabView](https://developer.apple.com/design/human-interface-guidelines/components/navigation-and-search/tab-bars) and [NavigationSplitView](https://developer.apple.com/design/human-interface-guidelines/components/layout-and-organization/split-views) based on horiontal size class. This framework allows you to easily build iPhone and iPad apps that conform to [Apple's Human Interface Guidelines](https://developer.apple.com/design/).

| iPhone | iPad |
| ------ | ---- |
|![Preview iPhone](https://github.com/mpdifran/AdaptiveTabView/blob/main/Resources/iPhone.png)|![Preview iPad](https://github.com/mpdifran/AdaptiveTabView/blob/main/Resources/iPad.png)|

Here's an example of how it can be used:

```swift
@main
struct MyApp: App {
    @State private var selectedTab = MyFirstTab.identifier

    var body: some Scene {
        WindowGroup {
            AdaptiveTabView(
                appName: "My App", 
                selectedTab: selectedTab
            ) {
                MyFirstTab()
                MySecondTab()
                MyThirdTab()
            } defaultContent: {
                MyDefaultContentView()
            } defaultDetail: {
                MyDefaultDetailView()
            } sidebarExtraContent: {
                Section {
                    ForEach(folders) { (folder) in
                        FolderSidebarCell(folder)
                    }
                }   
            }
        }
    }
}
```

```swift
extension MyFirstTab {
    static let identifier = TabIdentifier("MyFirstTab")
}

struct MyFirstTab: View, TitleImageProviding {
    let title = "My First Tab"
    let systemImageName = "1.square"
    let id = MyFirstTab.identifier

    var body: some View {
        ...
    }
}
```
