//
//  AppSettings.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 15/03/2026.
//

import Foundation

public struct AppSettings: FirestoreRecord, Sendable, Codable {
    public static let collectionPath = "settings"
    public let id: String
    public let apiKey: String

    public init(apiKey: String) {
        self.id = "app"
        self.apiKey = apiKey
    }
}
