// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "RaLog",
    platforms: [.iOS(.v10), .macOS(.v10_15)],
    products: [
        .library(name: "RaLog", targets: ["RaLog"])
    ],
    targets: [
        .target(name: "RaLog", path: "Sources")
    ]
)
