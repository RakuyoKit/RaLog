// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "RaLog",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_14),
        .tvOS(.v12),
        .watchOS(.v5),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "RaLog",
            targets: ["RaLog"]),
    ],
    targets: [
        .target(
            name: "RaLog",
            path: "Sources",
            resources: [.copy("PrivacyInfo.xcprivacy")]),
        .testTarget(
            name: "RaLogTests",
            dependencies: ["RaLog"]),
    ]
)
