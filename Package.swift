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
        .binaryTarget(name: "DixaMessenger", url: "https://github.com/dixahq/ios-messenger/releases/download/2.2.2/DixaMessenger.xcframework.zip", checksum: "2fa4d97436fd47f7fce7a9b28e2dcddfa1342f38d8dfd016cde0079c190df869")
    ]
)
