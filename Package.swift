// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "PositionalDateComponentsFormatter",
    platforms: [
      .iOS(.v13),
      .watchOS(.v4),
      .macOS(.v10_15),
      .tvOS(.v11)
    ],
    products: [
        .library(
            name: "PositionalDateComponentsFormatter",
            targets: ["PositionalDateComponentsFormatter"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PositionalDateComponentsFormatter",
            dependencies: []),
        .testTarget(
            name: "PositionalDateComponentsFormatterTests",
            dependencies: ["PositionalDateComponentsFormatter"]),
    ]
)
