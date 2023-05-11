// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "CloseEnough",
    platforms: [
        .iOS(.v13),
        .macCatalyst(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "CloseEnough",
            targets: ["CloseEnough"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CloseEnough",
            dependencies: []
        ),
        .testTarget(
            name: "CloseEnoughTests",
            dependencies: ["CloseEnough"]
        ),
    ]
)
