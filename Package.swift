// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MailCore2",
    platforms: [
        .iOS(.v16), .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "MailCore2",
            targets: ["MailCore2"]),
    ],
    targets: [
        .binaryTarget(name: "MailCore2",
                      url: "https://github.com/vikdenic/mailcore2/raw/arm64-simulator-support/bin/MailCore2-arm64-simulator.xcframework.zip",
                      checksum: "8f11b5c0afc2371f10ce7430b8b87a36b69c9d4057d9a10253bb6d5f2221bb76")
    ]
)
