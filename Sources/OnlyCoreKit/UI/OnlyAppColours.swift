//
//  OnlyAppColours.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 08/02/2026.
//

import Foundation
import SwiftUI

/// Exposure of palette colours from OnlyPalette.xcassets
public enum OnlyAppColours {
    
    public static var onlyPaletteBackground: Color { Color("onlyPaletteBackground", bundle: .module) }
    public static var onlyPaletteError: Color { Color("onlyPaletteError", bundle: .module) }
    public static var onlyPaletteLabel: Color { Color("onlyPaletteLabel", bundle: .module) }
    public static var onlyPaletteSuccess: Color { Color("onlyPaletteSuccess", bundle: .module) }
    public static var onlyLogoBlue: Color { Color("onlyLogoBlue", bundle: .module) }
    public static var onlyLogoPurple: Color { Color("onlyLogoPurple", bundle: .module) }
    public static var onlyLogoRed: Color { Color("onlyLogoRed", bundle: .module) }
    public static var onlyLogoYellow: Color { Color("onlyLogoYellow", bundle: .module) }
    
}
