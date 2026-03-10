//
//  CoreFirebase.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 04/03/2026.
//

import Foundation
import FirebaseFirestore

/// Entry point for OnlyCoreKit's Firebase layer.
///
/// Call `CoreFirebase.setup()` in implementation app's `init()`, after `FirebaseApp.configure()`:
/// ```swift
/// @main
/// struct MyApp: App {
///     init() {
///         FirebaseApp.configure()
///         CoreFirebase.setup()      // Configures Firestore settings
///     }
/// }
/// ```
///
/// - Important: Ensure you add `GoogleService-Info.plist` to app target after creating Firebase project in Firebase console: ``https://console.firebase.google.com/``
public enum CoreFirebase {

    /// Applies OnlyCoreKit's recommended Firestore settings.
    /// Extend this as the package grows (e.g. Functions region config).
    public static func setup() {
        configureFirestore()
    }

    // MARK: - Private

    private static func configureFirestore() {
        let settings = FirestoreSettings()
        // Enables local disk persistence so the app works offline
        // and syncs changes when connectivity is restored.
        settings.cacheSettings = PersistentCacheSettings()
        Firestore.firestore().settings = settings
    }
}

