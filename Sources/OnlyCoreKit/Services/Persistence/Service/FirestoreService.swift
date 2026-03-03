//
//  FirestoreService.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 03/03/2026.
//

import FirebaseFirestore
import Foundation

/// A generic Firestore service providing full CRUD and  real-time listening
/// for any model conforming to `FirestoreRecord` and `Sendable`.
///
/// ## Usage
/// ```swift
/// @StateObject private var modelService = FirestoreService<Model>()
/// ```
/// Then inject via `.environmentObject(modelService)` and consume with:
/// ```swift
/// @EnvironmentObject var modelService: FirestoreService<model>
/// ```
@MainActor
public final class FirestoreService<T: FirestoreRecord & Sendable>: ObservableObject {

    // MARK: - Published State

    /// The latest snapshot of all records in the collection.
    /// Automatically updated when using `startListening()`.
    @Published public var records: [T] = []

    /// True while any async operation is in flight.
    @Published public var isLoading: Bool = false

    /// Holds the last error thrown by any operation, if any.
    @Published public var error: Error? = nil

    // MARK: - Private

    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    /// Resolves the Firestore CollectionReference for T at call time.
    private var collection: CollectionReference {
        db.collection(T.collectionPath)
    }

    // MARK: - Init / Deinit

    public init() {}

    deinit {
        stopListening()
    }

    // MARK: - Create

    /// Writes a new document to Firestore using `record.id` as the document ID.
    /// If a document with this ID already exists, it will be overwritten.
    ///
    /// - Parameters:
    ///     - record: The model instance to persist.
    public func create(_ record: T) async throws {
        isLoading = true
        defer { isLoading = false }
        do {
            try collection.document(record.id).setData(from: record)
        } catch {
            self.error = error
            throw error
        }
    }

    // MARK: - Read

    /// Fetches a single document by ID and decodes it into T.
    ///
    /// - Parameters:
    ///     - id: The Firestore document ID to fetch.
    /// - Returns: A decoded instance of T.
    public func read(id: String) async throws -> T {
        isLoading = true
        defer { isLoading = false }
        do {
            return try await collection.document(id).getDocument(as: T.self)
        } catch {
            self.error = error
            throw error
        }
    }

    /// Fetches all documents in the collection and decodes them into [T].
    /// For large collections, consider adding query parameters (see `query` overload below).
    ///
    /// - Returns: An array of all decoded T instances in the collection.
    public func readAll() async throws -> [T] {
        isLoading = true
        defer { isLoading = false }
        do {
            let snapshot = try await collection.getDocuments()
            // compactMap skips documents that fail to decode rather than throwing entirely.
            // Swap for `map { try $0.data(as: T.self) }` if you want strict all-or-nothing.
            return snapshot.documents.compactMap { try? $0.data(as: T.self) }
        } catch {
            self.error = error
            throw error
        }
    }

    /// Fetches documents matching a Firestore query and decodes them into [T].
    /// Useful for filtering, ordering, and paginating large collections.
    ///
    /// Example:
    /// ```swift
    /// let query = Firestore.firestore()
    ///     .collection(Recipe.collectionPath)
    ///     .whereField("category", isEqualTo: "dessert")
    ///     .order(by: "name")
    /// let desserts = try await recipeService.readAll(query: query)
    /// ```
    public func readAll(query: Query) async throws -> [T] {
        isLoading = true
        defer { isLoading = false }
        do {
            let snapshot = try await query.getDocuments()
            return snapshot.documents.compactMap { try? $0.data(as: T.self) }
        } catch {
            self.error = error
            throw error
        }
    }

    // MARK: - Update

    /// Updates an existing document using `merge: true` so only fields present
    /// in your Swift model are touched — other Firestore fields are preserved.
    ///
    /// - Parameter record: The updated model instance. `record.id` identifies the document.
    public func update(_ record: T) async throws {
        isLoading = true
        defer { isLoading = false }
        do {
            try collection.document(record.id).setData(from: record, merge: true)
        } catch {
            self.error = error
            throw error
        }
    }

    // MARK: - Delete

    /// Permanently deletes a document from Firestore.
    ///
    /// - Parameter id: The Firestore document ID to delete.
    public func delete(id: String) async throws {
        isLoading = true
        defer { isLoading = false }
        do {
            try await collection.document(id).delete()
        } catch {
            self.error = error
            throw error
        }
    }

    // MARK: - Real-Time Listener

    /// Attaches a Firestore snapshot listener to the collection.
    /// `records` is updated automatically on every remote change.
    /// Call `stopListening()` when the listener is no longer needed.
    public func startListening() {
        listener = collection.addSnapshotListener { [weak self] snapshot, error in
            guard let self else { return }
            if let error {
                self.error = error
                return
            }
            guard let documents = snapshot?.documents else { return }
            
            self.records = documents.compactMap { try? $0.data(as: T.self) }
        }
    }

    /// Detaches the active snapshot listener. Called automatically on `deinit`.
    nonisolated public func stopListening() {
        Task { @MainActor [weak self] in
            self?.listener?.remove()
            self?.listener = nil
        }
    }
}
