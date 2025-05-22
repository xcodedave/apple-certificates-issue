#!/bin/bash

set -e

xcodebuild archive \
    -scheme CertificatesIssue \
    -destination "generic/platform=iOS" \
    -archivePath ./archives/ios_device \
    -sdk iphoneos \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SWIFT_OPTIMIZATION_LEVEL=-Onone
