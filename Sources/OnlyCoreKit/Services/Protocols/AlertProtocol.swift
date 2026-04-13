//
//  AlertProtocol.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 08/04/2026.
//

import Foundation
import SwiftUI



/// Custom alerts must conform to   `AlertProtocol`
///
/// - Parameters:
///     - id: `UUID`
///     - alertType: `AlertType` enum specifying button options
///     - title: `String` representing alert title
///     - description: `String?` representing the optional alert description
///     - image: `Image` representing the optional alert image
///     - userInputPlaceholder: `String?` representing the optional placeholder for the user input text field
///
/// ## Usage
/// ``` swift
/// struct UserNameAlert: AlertProtocol {
///  var id = UUID()
///  var alertType: AlertType = .actionAndCancel
///  var title: String = "Add your name"
///  var description: String? = "even a nickname, it doesn't matter"
///  var image: Image? = nil
///  var userInputPlaceholder: String? = "Enter name"
/// }
/// ```
///
public protocol AlertProtocol: Identifiable {
    var id: UUID { get }
    var alertType: AlertType { get }
    var title: String { get }
    var description: String? { get }
    var image: Image? { get }
    var userInputPlaceholder: String? { get }
}
