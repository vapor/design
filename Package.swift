// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "DesignSite",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "DesignSite",
            targets: ["DesignSite"]
        ),
        .library(name: "VaporDesign", targets: ["VaporDesign"]),
        // Shared Leaf templates for Vapor's Kiln sites, shipped as a resource.
        .library(name: "VaporDesignTheme", targets: ["VaporDesignTheme"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.8.0")
    ],
    targets: [
        .executableTarget(
            name: "DesignSite",
            dependencies: [
                .product(name: "Publish", package: "publish"),
                "VaporDesign"
            ]
        ),
        .target(
            name: "VaporDesign",
            dependencies: [
                .product(name: "Publish", package: "publish")
            ]
        ),
        // No dependencies beyond Foundation — just bundles the shared Leaf
        // templates so consuming Kiln sites can pull them in as a theme layer.
        .target(
            name: "VaporDesignTheme",
            exclude: ["README.md"],
            resources: [.copy("Theme")],
        )
    ]
)
