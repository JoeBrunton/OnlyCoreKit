//
//  AppSettingsService.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 15/03/2026.
//

import Foundation

/// Provides a consistent way of communicating with App Settings as well as secure API Key storage
///
/// ## Usage:
/// ``` swift
///@StateObject private var settingsService = AppSettingsService()
///
///    .task {
///        await settingsService.fetchAPIKey()
///    }
///
///    // Then wherever you need the key:
///    if let key = settingsService.apiKey {
///        // use key
///    }
/// ```
@MainActor
public final class AppSettingsService: ObservableObject {

    @Published public var apiKey: String? = nil
    @Published public var isLoading: Bool = false
    @Published public var error: Error? = nil

    private let firestoreService = FirestoreService<AppSettings>()

    public init() {}

    /// Fetches the API key from `settings/app`. Safe to call on app launch.
    public func fetchAPIKey() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let settings = try await firestoreService.read(id: "app")
            self.apiKey = settings.apiKey
        } catch {
            self.error = error
        }
    }
}
