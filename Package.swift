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
// Add the Rakuyo Swift formatting plugin if possible
package.dependencies.append(.package(url: "https://github.com/RakuyoKit/swift.git", from: "1.2.2"))
#endif
