// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "RaLog",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
        .tvOS(.v12),
        .watchOS(.v5),
    ],
    products: [
        .library(
            name: "RaLog",
            targets: ["RaLog"]
        ),
    ],
    targets: [
        .target(
            name: "RaLog",
            path: "Sources/Core"
        ),
        .testTarget(
            name: "RaLogTests",
            dependencies: ["RaLog"],
            path: "Tests"
        ),
    ]
)

#if swift(>=5.6)
// Add the Swift formatting plugin if possible
package.dependencies.append(.package(url: "https://github.com/RakuyoKit/swift.git", branch: "release/1.4.0"))
#endif
