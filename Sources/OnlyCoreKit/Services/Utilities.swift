//
//  Utilities.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 13/03/2026.
//

import Foundation
import UIKit
import SwiftUI

/// Struct containing useful functions
///
/// - Note: May be deprecated in favour of extensions.. 😐
public struct Utilities {
    
    public init() { }
    
    /// Creates a `UIColor` from an RGB hexadecimal value.
    ///
    /// The input should be in the format `0xRRGGBB`.
    ///
    /// Example:
    /// ```swift
    /// let color = UIColorFromRGB(rgbValue: 0xFF0000) // red
    /// ```
    ///
    /// - Parameter rgbValue: A hexadecimal RGB value in the format `0xRRGGBB`.
    /// - Returns: A `UIColor` representing the provided RGB value.
    public static func UIColorFromHexRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /// Converts a `UIColor` into an RGB hexadecimal value.
    ///
    /// The returned value is formatted as `0xRRGGBB`.
    ///
    /// Example:
    /// ```swift
    /// let rgb = RGBFromUIColor(.systemBlue)
    /// ```
    ///
    /// - Parameter uiColor: The `UIColor` to convert.
    /// - Returns: A hexadecimal RGB value in the format `0xRRGGBB`.
    public static func HexRGBFromUIColor(_ uiColor: UIColor) -> UInt {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let r = UInt(red * 255.0) << 16
        let g = UInt(green * 255.0) << 8
        let b = UInt(blue * 255.0)
        
        return r | g | b
    }
    
    /// Converts a SwiftUI `Color` into an RGB hexadecimal value.
    ///
    /// The returned value is formatted as `0xRRGGBB`. Internally this
    /// converts the `Color` to a `UIColor` before extracting the RGB components.
    ///
    /// Example:
    /// ```swift
    /// let rgb = RGBFromColor(.blue)
    /// ```
    ///
    /// - Parameter color: The SwiftUI `Color` to convert.
    /// - Returns: A hexadecimal RGB value in the format `0xRRGGBB`.
    public static func HexRGBFromColor(_ color: Color) -> UInt {
        let uiColor = UIColor(color)
        return HexRGBFromUIColor(uiColor)
    }
    
    
    /// Calculates the current age of an object e.g. User from a `Date`
    /// - Parameter dob: "Date of Birth"
    /// - Returns: an `Int` representing the age of the object
    public static func age(from dob: Date) -> Int {
        let calendar = Calendar.current
        let now = Date()

        let years = calendar.dateComponents([.year], from: dob, to: now).year ?? 0

        let birthdayThisYear = calendar.date(
            bySetting: .year,
            value: calendar.component(.year, from: now),
            of: dob
        ) ?? dob

        return now >= birthdayThisYear ? years : years - 1
    }
}
