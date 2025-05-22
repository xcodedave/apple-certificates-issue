//
//  CertificatesIssue.swift
//  CertificatesIssue
//
//  Created by xcodedave on 22/05/2025.
//

import X509

/// This function is included for the sake of a demo
/// in order to avoid symbol-stripping of unused dependencies
/// - parameters:
///     - derEncoded: The DER-encoded bytes representing this object.
@available(macOS 10.15, *)
public func example(derEncoded: [UInt8]) throws -> Certificate {
  try Certificate(derEncoded: [])
}
