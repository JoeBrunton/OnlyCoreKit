//
//  UserImage.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 20/03/2026.
//

import Foundation
import SwiftUI


/// A collection of potential forms a user image can take
public enum UserImage: Codable, Sendable {
//    case assetImage(Image) // DOESN'T CONFORM TO CODABLE
    case url(String)
    case data(Data)
}
