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
        .binaryTarget(name: "DixaMessenger", url: "https://github.com/dixahq/ios-messenger/releases/download/1.6.7/DixaMessenger.xcframework.zip", checksum: "9e41266a8f600fa9c4a2c7c76f37f4b2e70c85e92e60cec317b2dd97bd61c0d3")
    ]
)
