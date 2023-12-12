// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DixaMessenger",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DixaMessenger",
            targets: ["DixaMessenger"]),
    ],
    targets: [
        .binaryTarget(name: "DixaMessenger", url: "https://github.com/dixahq/ios-messenger/releases/download/1.7.6/DixaMessenger.xcframework.zip", checksum: "736659929c5f5b66ee3aef21ab4565a75ab72192617f0b5e526d236323b9fec8")
    ]
)
