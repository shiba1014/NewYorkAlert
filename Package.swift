// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NewYorkAlert",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "NewYorkAlert", targets: ["NewYorkAlert"])
    ],
    targets: [
        .target(name: "NewYorkAlert", path: "Sources"),
    ],
    swiftLanguageVersions: [.v5]
)
