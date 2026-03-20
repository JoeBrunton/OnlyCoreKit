//
//  UserUpdateRequest.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 20/03/2026.
//

import Foundation


/// The object of the updated fields from the `UserInformationView` when update button is pressed.
/// 
/// - Parameters:
///     - name: `String` representing the updated name field
///     - pronouns: `Pronoun` representing the updated pronoun object
///     - dob: `Date` representing the updated Date of Birth
///     - image: `UserImage` representing the updated image - will currently always be `Data`
public struct UserUpdateRequest {
    
    public init(name: String, pronouns: Pronoun, dob: Date, image: UserImage? = nil) {
        self.name = name
        self.pronouns = pronouns
        self.dob = dob
        self.image = image
    }

    public var name: String
    public var pronouns: Pronoun
    public var dob: Date
    public var image: UserImage?
    
}
