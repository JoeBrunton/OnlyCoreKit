//
//  FirestoreRecord.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 03/03/2026.
//

import Foundation


/// Conform any app-side model to this protocol to unlock
/// full Firestore CRUD support via FirestoreService<T>.
///
/// ## Usage
/// ```swift
/// struct Recipe: FirestoreRecord, Codable, Sendable {
///     var id: String
///     var name: String
///     var ingredients: [String]
///     static var collectionPath: String { "recipes" }
/// }
/// ```
///
/// - Important: Models must confform to `Sendable`
public protocol FirestoreRecord: Codable, Identifiable {
    
    /// - Important:  Make sure this is a UUID string
    var id: String { get }
    
    /// The Firestore collection this model lives in.
    ///
    ///
    /// Defined as `static` because the collection is the same for all instances of the type.
    /// e.g. `"users/\(uid)/createdRecipes"`
    static var collectionPath: String { get }
}
