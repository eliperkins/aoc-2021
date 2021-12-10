// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "aoc-2021",
    platforms: [.macOS(.v11)],
    products: [
        .library(
            name: "AdventOfCode2021",
            targets: ["AdventOfCode2021"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-collections", from: "1.0.2"),
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.2"),
        .package(url: "https://github.com/ChimeHQ/Flexer.git", .revision("16eafa09e2137fdbb14dadc2296adfedd53f1593")),
    ],
    targets: [
        .target(
            name: "AdventOfCode2021",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "Numerics", package: "swift-numerics"),
                .product(name: "Flexer", package: "Flexer"),
            ]
        ),
        .testTarget(
            name: "AdventOfCode2021Tests",
            dependencies: ["AdventOfCode2021"]
        ),
    ]
)
