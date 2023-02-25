// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdaptiveTabView",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
    ],
    products: [
        .library(
            name: "AdaptiveTabView",
            targets: ["AdaptiveTabView"]),
    ],
    dependencies: [
        .package(url: "git@github.com:andtie/SequenceBuilder.git", from: "0.0.7")
    ],
    targets: [
        .target(
            name: "AdaptiveTabView",
            dependencies: ["SequenceBuilder"])
    ]
)
