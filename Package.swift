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
        .binaryTarget(name: "DixaMessenger", url: "https://github.com/dixahq/ios-messenger/releases/download/1.6.9/DixaMessenger.xcframework.zip", checksum: "76887814196f797b491635907c73280dae278ef5bec9e9ea40e2b3f0b1d5d5c0")
    ]
)
