# App Store Connect API Swift Language Code

[![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square)](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-macOS-orange?style=flat-square)](https://img.shields.io/badge/Platforms-macOS-orange?style=flat-square)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)

This Swift code generator is built upon the [Swift OpenAPI Generator](https://github.com/apple/swift-openapi-generator) and leverages the OpenAPI description for App Store Connect API. The goal is to automate the creation of Swift language bindings, providing developers with a seamless way to interact with App Store Connect' REST API.

## Usage


## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up,  adding it to the `dependencies` value of your `Package.swift`.

```swift
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

dependencies: [
    .package(url: "https://github.com/Wei18/app-store-connect-api-swift-openapi.git", from: "1.0.0"),
]
```

## Overview

[OpenAPI](https://www.openapis.org/) serves as a standardized way to document HTTP services. It allows developers to automate workflows, such as generating code for making HTTP requests or implementing API servers. 

The [Swift OpenAPI Generator](https://github.com/apple/swift-openapi-generator) is a Swift package plugin designed to generate code at build-time, ensuring it remains synchronized with the OpenAPI document.

Use [Github Action Schedule](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#schedule) to download the [OpenAPI specification](https://developer.apple.com/documentation/appstoreconnectapi#:~:text=OpenAPI%20specification) file from [App Store Connect API documentation](https://developer.apple.com/documentation/appstoreconnectapi) then create generated module (Swift Package).

# Contributions

Contributions are welcome! If you encounter issues or have suggestions for improvements, feel free to open an issue or submit a pull request.
