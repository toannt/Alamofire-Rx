// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Alamofire+Rx",
    platforms: [.macOS(.v10_12),
                .iOS(.v10),
                .tvOS(.v10),
                .watchOS(.v3)],
    products: [
        .library(
            name: "Alamofire+Rx",
            targets: ["Alamofire+Rx"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.0.0-rc.2")),
    ],
    targets: [
        .target(
            name: "Alamofire+Rx",
            dependencies: ["Alamofire", "RxSwift"]),
        .testTarget(
            name: "Alamofire+RxTests",
            dependencies: ["Alamofire+Rx"]),
    ],
    swiftLanguageVersions: [.v5]
)
