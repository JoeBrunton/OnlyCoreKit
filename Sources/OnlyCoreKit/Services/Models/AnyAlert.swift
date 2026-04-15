//
//  AnyAlert.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 15/04/2026.
//

import Foundation

public struct AnyAlert: Identifiable {
    public let id: UUID
    public let base: any AlertProtocol

    public init(_ base: any AlertProtocol) {
        self.id = base.id
        self.base = base
    }
}
