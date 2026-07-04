// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "DesignSite",
    platforms: [.macOS(.v13)],
    products: [
        // The design.vapor.codes style guide, built with Kiln.
        .executable(
            name: "DesignSite",
            targets: ["DesignSite"]
        ),
        // Shared Leaf templates for Vapor's Kiln sites, shipped as a resource.
        .library(name: "VaporDesignTheme", targets: ["VaporDesignTheme"]),
    ],
    dependencies: [
        .package(url: "https://github.com/brokenhandsio/kiln.git", from: "1.4.0"),
    ],
    targets: [
        .executableTarget(
            name: "DesignSite",
            dependencies: [
                .product(name: "Kiln", package: "kiln"),
            ]
        ),
        // No dependencies beyond Foundation — just bundles the shared Leaf
        // templates so consuming Kiln sites can pull them in as a theme layer.
        .target(
            name: "VaporDesignTheme",
            exclude: ["README.md"],
            resources: [.copy("Theme")]
        ),
    ]
)
