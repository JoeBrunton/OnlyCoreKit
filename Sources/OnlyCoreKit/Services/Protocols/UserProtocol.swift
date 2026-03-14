//
//  UserProtocol.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 14/03/2026.
//

import Foundation

protocol UserProtocol: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var pronouns: String { get }
    var dob: Date { get }
}
