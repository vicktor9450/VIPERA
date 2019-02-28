// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "vipera",
    products: [
        .executable(name: "vipera", targets: ["vipera"]),
    ],
    dependencies: [
        .package(url: "https://github.com/binarybirds/dir", from: "1.0.0"),
        .package(url: "https://github.com/binarybirds/spm", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "vipera",
            dependencies: ["Dir"],
            path: "./Sources/vipera"),
        .target(
            name: "install",
            dependencies: ["Dir", "SPM"],
            path: "./Sources/install"),
        .testTarget(
            name: "viperaTests",
            dependencies: ["vipera"]),
    ]
)
