// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "DesignSite",
    platforms: [.macOS(.v13)],
    products: [
        .executable(
            name: "DesignSite",
            targets: ["DesignSite"]
        ),
        .library(name: "VaporDesignTheme", targets: ["VaporDesignTheme"]),
    ],
    dependencies: [
        .package(url: "https://github.com/brokenhandsio/kiln.git", from: "1.7.0"),
        // LeafKit — so VaporDesignTheme can define its own Leaf tags (the
        // `#designResource` asset-URL tag). Kept in lockstep with Kiln's own
        // leaf-kit requirement so SwiftPM resolves a single version.
        .package(url: "https://github.com/vapor/leaf-kit.git", from: "1.14.0"),
    ],
    targets: [
        .executableTarget(
            name: "DesignSite",
            dependencies: [
                .product(name: "Kiln", package: "kiln"),
                "VaporDesignTheme",
            ]
        ),
        .target(
            name: "VaporDesignTheme",
            dependencies: [
                .product(name: "LeafKit", package: "leaf-kit"),
            ],
            exclude: ["README.md"],
            resources: [.copy("Theme")]
        ),
        .testTarget(
            name: "VaporDesignThemeTests",
            dependencies: [
                "VaporDesignTheme",
                .product(name: "Kiln", package: "kiln"),
                .product(name: "LeafKit", package: "leaf-kit"),
            ]
        ),
    ]
)
