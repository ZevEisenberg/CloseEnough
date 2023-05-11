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
        .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay.git", exact: "0.8.4"), // should pin more leniently post-1.0
    ],
    targets: [
        .target(
            name: "CloseEnough",
            dependencies: [
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        .testTarget(
            name: "CloseEnoughTests",
            dependencies: ["CloseEnough"]
        ),
    ]
)
