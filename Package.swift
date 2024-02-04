// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ECE564Login",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ECE564Login",
            targets: ["ECE564Login"]),
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-spm.git", .upToNextMajor(from: "4.4.0")),
        .package(url: "https://github.com/Ramotion/paper-onboarding.git", .upToNextMajor(from: "6.1.5")),
        .package(url: "https://github.com/changemin/LoadingButton.git", .upToNextMajor(from: "1.1.2")),
        .package(url: "https://github.com/SwiftfulThinking/SwiftfulLoadingIndicators.git", .upToNextMajor(from: "0.0.4"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ECE564Login",
            dependencies: [.product(name: "Lottie", package: "lottie-spm"), .product(name: "PaperOnboarding", package: "paper-onboarding"), "LoadingButton", "SwiftfulLoadingIndicators"]),
        .testTarget(
            name: "ECE564LoginTests",
            dependencies: ["ECE564Login"]),
    ]
)
