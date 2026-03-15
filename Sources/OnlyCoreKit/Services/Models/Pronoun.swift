//
//  Pronoun.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 14/03/2026.
//

import Foundation
import SwiftUI


/// Model describing a pronoun
/// - Parameters:
///     - id: UUID
///     - pronoun: String containing the textual representation of the pronoun
///     - foregroundRGB: UInt containing the Hex RGB foreground colour for a label
///     - backgroundRGB: UInt containing the Hex RGB background colour for a label
///
/// The struct contains static properties of the most common pronouns
///
/// - Important:
/// Use `Utilities.HexRGBFrom...` to convert fore and background colours to a `Codable` format.
///
/// ## Usage:
/// A static pronoun:
/// ``` swift
/// Button {
///     // set pronoun
/// } label: {
///     ReuseButtonView(text: Pronoun.sheHer.pronoun,
///                     foreColour: Color(uiColor: Utilities.UIColorFromHexRGB(rgbValue: Pronoun.sheHer.foregroundRGB),
///                     backColour: Color(uiColor: Utilities.UIColorFromHexRGB(rgbValue: Pronoun.sheHer.backgroundRGB))
/// }
/// ```
///
/// /// A custom pronoun:
/// ``` swift
///let leafLeaves = Pronoun(pronoun: "Leaf / Leaves",
///                         foregroundRGB: Utilities.HexRGBFromUIColor(UIColor.green),
///                         backgroundRGB: Utilities.HexRGBFromUIColor(UIColor.black))
///
/// Button {
///     // set pronoun
/// } label: {
///     ReuseButtonView(text: leafLeaves.pronoun,
///                     foreColour: Color(uiColor: Utilities.UIColorFromHexRGB(rgbValue: leafLeaves.foregroundRGB),
///                     backColour: Color(uiColor: Utilities.UIColorFromHexRGB(rgbValue: leafLeaves.backgroundRGB))
/// }
/// ```
public struct Pronoun: Identifiable, Sendable, Codable {
    public init(id: UUID = UUID(), pronoun: String, foregroundRGB: UInt, backgroundRGB: UInt) {
        self.id = id
        self.pronoun = pronoun
        self.foregroundRGB = foregroundRGB
        self.backgroundRGB = backgroundRGB
    }
    
    public var id: UUID = UUID()
    public var pronoun: String
    public var foregroundRGB: UInt
    public var backgroundRGB: UInt
    
    
    public static let sheHer = Pronoun(
        pronoun: "She / Her",
        foregroundRGB: Utilities.HexRGBFromUIColor(UIColor.lightGray),
        backgroundRGB: Utilities.HexRGBFromColor(ProgressPalette.progressPink))
    public static let theyThem = Pronoun(
        pronoun: "They / Them",
        foregroundRGB: Utilities.HexRGBFromUIColor(UIColor.white),
        backgroundRGB: Utilities.HexRGBFromUIColor(UIColor.lightGray))
    public static let heHim = Pronoun(
        pronoun: "He / Him",
        foregroundRGB: Utilities.HexRGBFromUIColor(UIColor.white),
        backgroundRGB: Utilities.HexRGBFromColor(ProgressPalette.progressDarkBlue))
    public static let sheThey = Pronoun(
        pronoun: "She / They",
        foregroundRGB: Utilities.HexRGBFromUIColor(UIColor.white),
        backgroundRGB: Utilities.HexRGBFromColor(ProgressPalette.progressRed))
    public static let heThey = Pronoun(
        pronoun: "He / They",
        foregroundRGB: Utilities.HexRGBFromUIColor(UIColor.white),
        backgroundRGB: Utilities.HexRGBFromColor(ProgressPalette.progressLightBlue))
    public static let zeZim = Pronoun(
        pronoun: "Ze / Zim",
        foregroundRGB: Utilities.HexRGBFromUIColor(UIColor.lightGray),
        backgroundRGB: Utilities.HexRGBFromColor(ProgressPalette.progressGreen))
    public static let xeXim = Pronoun(
        pronoun: "Xe / Xim",
        foregroundRGB: Utilities.HexRGBFromUIColor(UIColor.lightGray),
        backgroundRGB: Utilities.HexRGBFromColor(ProgressPalette.progressYellow))
    public static let verVis = Pronoun(
        pronoun: "Ver / Vis",
        foregroundRGB: Utilities.HexRGBFromUIColor(UIColor.lightGray),
        backgroundRGB: Utilities.HexRGBFromColor(ProgressPalette.progressOrange))
    public static let teTer = Pronoun(
        pronoun: "Te / Ter",
        foregroundRGB: Utilities.HexRGBFromUIColor(UIColor.lightGray),
        backgroundRGB: Utilities.HexRGBFromColor(ProgressPalette.progressPurple))
}
