// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SIXQuiz",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SIXQuiz",
            targets: ["SIXQuiz"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Sixtema6T/SIXFonts", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SIXQuiz",
            dependencies: ["SIXFonts"],
            resources: [
                .process("Assets.xcassets")
            ]
        ),
        .testTarget(
            name: "SIXQuizTests",
            dependencies: ["SIXQuiz"]
        ),
    ]
)
