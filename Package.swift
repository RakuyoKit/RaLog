// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "RaLog",
    platforms: [.iOS(.v12), .macOS(.v10_14), .tvOS(.v12), .watchOS(.v5)],
    products: [
        .library(
            name: "RaLog",
            targets: ["RaLog"]),
    ],
    targets: [
        .target(
            name: "RaLog",
            path: "Sources"),
        .testTarget(
            name: "RaLogTests",
            dependencies: ["RaLog"],
            path: "Tests"),
    ]
)
