//
//  UserProtocol.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 14/03/2026.
//

import Foundation


/// Each client side User object must conform to `UserProtocol` to be used in `UserInformationView`
///
/// - Parameters:
///     - id: `UUID`
///     - name: `String` representing the User's name
///     - pronouns: `Pronoun` containing information on the User's pronouns
///     - dob: `Date` representing the User's Date of Birth
///     - image: `UserImage` containing a User image
public protocol UserProtocol: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var pronouns: Pronoun { get }
    var dob: Date { get }
    var image: UserImage? { get }
}
