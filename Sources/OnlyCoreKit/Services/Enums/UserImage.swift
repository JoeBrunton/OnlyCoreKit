//
//  UserImage.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 20/03/2026.
//

import Foundation
import SwiftUI


/// A collection of potential forms a user image can take
public enum UserImage {
    case assetImage(Image)
    case url(String)
    case data(Data)
}
