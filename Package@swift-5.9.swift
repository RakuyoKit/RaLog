// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "RaLog",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
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
            resources: [.copy("PrivacyInfo.xcprivacy")]),
        .testTarget(
            name: "RaLogTests",
            dependencies: ["RaLog"]),
    ]
)

// Add the Rakuyo Swift formatting plugin
package.dependencies.append(.package(url: "https://github.com/RakuyoKit/swift.git", from: "1.1.2"))
