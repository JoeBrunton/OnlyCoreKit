//
//  UserInformationViewModel.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 18/03/2026.
//

import Foundation
import SwiftUI
import PhotosUI

extension UserInformationView {
    
    /// A view model that manages the display and editing state of a user.
    ///
    /// `UserInformationViewModel` acts as an adapter between a type conforming to
    /// ``UserProtocol`` and SwiftUI views. It exposes editable properties for user
    /// fields and coordinates save actions via an injected closure.
    ///
    /// The view model is isolated to the main actor to ensure UI updates are safe.
    ///
    /// ## Responsibilities
    /// - Provides display-ready user data
    /// - Manages edit state (`isEditing`)
    /// - Holds temporary editable values
    /// - Emits update requests via `onSave`
    ///
    /// ## Usage
    /// ```swift
    /// let vm = UserInformationViewModel(user: currentUser) { update in
    ///     try await userService.updateUser(update)
    /// }
    /// ```
    ///
    /// - Note: If no `onSave` closure is provided, save operations will be ignored.
    @MainActor
    @Observable
    public class ViewModel {
        
        public init(user: any UserProtocol, onSave: @escaping (UserUpdateRequest)  async throws -> Void = { _ in }) {
            self.user = user
            self.onSave = onSave
            
            self.name = user.name
            self.pronouns = user.pronouns
            self.dob = user.dob
            self.userImage = user.image
            self.selectedImageItem = nil
        }
        
        private var user: any UserProtocol
        private var onSave: (UserUpdateRequest) async throws -> Void
        
        var name: String
        var pronouns: Pronoun
        var dob: Date = Date()
        var userImage: UserImage?
        
        var isEditing: Bool = false
        
        let pronounsArray: [Pronoun] = [
            Pronoun.heHim,
            Pronoun.heThey,
            Pronoun.sheHer,
            Pronoun.sheThey,
            Pronoun.teTer,
            Pronoun.theyThem,
            Pronoun.verVis,
            Pronoun.xeXim,
            Pronoun.zeZim
        ]
        
        var selectedImageItem: PhotosPickerItem?
        
        func save() async {
            let update = UserUpdateRequest(name: name,
                                           pronouns: pronouns,
                                           dob: dob,
                                           image: userImage)
            
            try? await onSave(update)
            isEditing = false
        }
        
        func cancel() {
            name = user.name
            pronouns = user.pronouns
            dob = user.dob
            userImage = user.image
            isEditing = false
        }
        
        func loadImage() {
            Task {
                guard let item = selectedImageItem else { return }
                
                if let data = try? await item.loadTransferable(type: Data.self) {
                    await MainActor.run {
                        userImage = .data(data)
                    }
                }
            }
        }
    }
}
