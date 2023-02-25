# AdaptiveTabView

An adaptive SwiftUI container that switches between [TabView](https://developer.apple.com/design/human-interface-guidelines/components/navigation-and-search/tab-bars) and [NavigationSplitView](https://developer.apple.com/design/human-interface-guidelines/components/layout-and-organization/split-views) based on horiontal size class. This framework allows you to easily build iPhone and iPad apps that conform to [Apple's Human Interface Guidelines](https://developer.apple.com/design/).

Here's an example of how it can be used:

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            AdaptiveTabView(appName: "My App") {
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
struct MyFirstTab: View, TitleImageProviding {
    let title = "My First Tab"
    let systemImageName = "1.square"

    var body: some View {
        ...
    }
}
```
