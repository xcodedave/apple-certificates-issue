// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CertificatesIssue",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "CertificatesIssue",
            type: .static,
            targets: ["CertificatesIssue"]
        ),
    ],
    dependencies: [
      .package(
        url: "https://github.com/apple/swift-certificates.git", .upToNextMajor(from: "1.0.0")
      )
    ],
    targets: [
        .target(
            name: "CertificatesIssue",
            dependencies: [
              .product(name: "X509", package: "swift-certificates")
            ],
            linkerSettings: [
              .linkedFramework("ProximityReader")
            ]
        ),
    ]
)
