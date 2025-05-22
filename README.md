# apple-certificates-issue
A demo of `swift-certificates` synthesized initializer issues when archiving a library for distribution when including 
a dependency upon the [swift-certificates](https://github.com/apple/swift-certificates) package.

> [!IMPORTANT] 
> `swift-certificates` version `1.10.0` was tested.
> 
> The following system configuration was used for testing:
> - macOS Sequoia 15.5 (24F74)
> - Xcode Version 16.3 (16E140)
> - Apple Swift version 6.1 (swift-6.1-RELEASE) Target: x86_64-apple-macosx15.0

## About

This repo demonstrates a Swift package based static library including `swift-certificates` as a dependency.
When `xcodebuild` is used to archive the library as a static distributable (e.g. for later packaging within an `.xcframework`),
the synthesized internal `init` function for `_TinyArray.swift` causes the compiler to throw errors when `@Inlinable` 
properties are set during initialization. e.g.:
```swift
self.storage = try .init(elements)
```

When attempting to archive the library is via the following command to `xcodebuild`:
```bash
xcodebuild archive \
    -scheme CertificatesIssue \
    -destination "generic/platform=iOS" \
    -archivePath ./archives/ios_device \
    -sdk iphoneos \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SWIFT_OPTIMIZATION_LEVEL=-Onone
```

`xcodebuild` emits the following errors:

```bash
swift-certificates/Sources/_CertificateInternals/_TinyArray.swift:83:22: error: 'self' used before 'self.init' call or assignment to 'self'
        self.storage = try .init(elements)
                     ^
/swift-certificates-issue-haifqbkeklqjiqdfqduvamwfokjt/SourcePackages/checkouts/swift-certificates/Sources/_CertificateInternals/_TinyArray.swift:84:5: error: 'self.init' isn't called on all paths before returning from initializer
    }
    ^

SwiftEmitModule normal arm64 Emitting\ module\ for\ SwiftASN1 (in target 'SwiftASN1' from project 'swift-asn1')

EmitSwiftModule normal arm64 (in target 'SwiftASN1' from project 'swift-asn1')
    cd /swift-certificates-issue/.swiftpm/xcode
    

SwiftEmitModule normal arm64 Emitting\ module\ for\ Crypto (in target 'Crypto' from project 'swift-crypto')
Command SwiftEmitModule failed with a nonzero exit code

** ARCHIVE FAILED **
```

## Steps To Reproduce

To reproduce this error, from the root of this repo execute the following in your terminal:

```bash
sh build.sh
```

## Potential Solution

A potential fix could be to explicitly define an initializer for `_TinyArray`, marked with
the `@usableFromInline` attribute.

Replacing property setup such as:
```swift
self.storage = try .init(elements)
```

With explicit use of the `init` function as follows could resolve these build issues:
```swift
try self.init(storage: .init(elements))
```