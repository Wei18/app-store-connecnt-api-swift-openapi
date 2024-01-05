// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

protocol PackageConfigSpec {
    var libraries: [PackageDescription.Product] { get }
    var targets: [PackageDescription.Target] { get }
}

struct SourceCodePackageConfigSpec: PackageConfigSpec {

    let targetName = "AppStoreConnectAPIOAS"

    var libraries: [PackageDescription.Product] {
        return [.library(name: targetName, targets: [targetName])]
    }

    var targets: [PackageDescription.Target] {
        return [
            .target(
                name: targetName,
                dependencies: [
                    .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                    .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
                ],
                exclude: [
                    "openapi-generator-config.yml",
                    "openapi.yml",
                ]
            )
        ]
    }

}

let config: PackageConfigSpec = SourceCodePackageConfigSpec()

let package = Package(
    name: "AppStoreConnectAPIOAS",
    platforms: [.macOS(.v10_15)],
    products: config.libraries,
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.0"),
    ],
    targets: config.targets
)
