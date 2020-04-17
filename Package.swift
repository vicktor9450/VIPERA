// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "vipera",
    products: [
        .executable(name: "vipera", targets: ["vipera"]),
        .library(name: "ViperaModules", targets: ["ViperaModules"])
    ],
    dependencies: [
        .package(url: "https://github.com/binarybirds/dir", from: "1.0.0"),
        .package(url: "https://github.com/binarybirds/spm", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "ViperaModules",
            dependencies: ["Dir"]),
        .target(
            name: "vipera",
            dependencies: ["Dir", "ViperaModules"],
            path: "./Sources/vipera"),
        .target(
            name: "install",
            dependencies: ["Dir", "SPM"],
            path: "./Sources/install"),
        .testTarget(
            name: "viperaTests",
            dependencies: ["ViperaModules"]),
    ]
)
