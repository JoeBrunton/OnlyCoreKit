//
//  Utilities.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 13/03/2026.
//

import Foundation
import UIKit

public struct Utilities {
    
    public init() { }
    
    public func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
