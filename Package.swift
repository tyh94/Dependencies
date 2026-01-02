// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dependencies",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Dependencies",
            type: .static,
            targets: ["Dependencies"]),
    ],
    dependencies: [
        .package(url: "git@github.com:tyh94/SnapshotsKit.git", from: "1.0.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Dependencies"),
        .testTarget(
            name: "DependenciesTests",
            dependencies: [
                "Dependencies",
                .product(name: "SnapshotsKit", package: "SnapshotsKit"),
            ],
            path: "Tests",
            exclude: [
                "__Snapshots__"
            ]
        ),
    ]
)
