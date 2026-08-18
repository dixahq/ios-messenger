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
        .binaryTarget(name: "DixaMessenger", url: "https://github.com/dixahq/ios-messenger/releases/download/2.2.3/DixaMessenger.xcframework.zip", checksum: "0daf36e891c1a0a85bdd03d727290ecb3798078282fba32105f637262f9496a5")
    ]
)
