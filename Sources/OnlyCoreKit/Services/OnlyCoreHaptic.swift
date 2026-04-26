//
//  OnlyCoreHaptic.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 21/04/2026.
//

import UIKit
import SwiftUI


/// Definition of useful haptics and exposure of preparation and firing through public functions
@MainActor
public enum OnlyCoreHaptic {

    // MARK: - Generators
    private static let lightImpact = UIImpactFeedbackGenerator(style: .light)
    private static let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
    private static let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    private static let softImpact = UIImpactFeedbackGenerator(style: .soft)

    private static let selection = UISelectionFeedbackGenerator()
    private static let notification = UINotificationFeedbackGenerator()

    // MARK: - Preparation

    public static func prepareLight() {
        lightImpact.prepare()
    }

    public static func prepareMedium() {
        mediumImpact.prepare()
    }

    public static func prepareHeavy() {
        heavyImpact.prepare()
    }

    public static func prepareSoft() {
        softImpact.prepare()
    }

    public static func prepareSelection() {
        selection.prepare()
    }

    // MARK: - Impacts

    public static func light() {
        lightImpact.impactOccurred()
    }

    public static func medium() {
        mediumImpact.impactOccurred()
    }

    public static func heavy() {
        heavyImpact.impactOccurred()
    }

    public static func soft(intensity: CGFloat = 1.0) {
        softImpact.impactOccurred(intensity: intensity)
    }

    // MARK: - Selection (UI scrolling, toggles)

    public static func tick() {
        selection.selectionChanged()
    }

    // MARK: - Notifications (system feedback)

    public static func success() {
        notification.notificationOccurred(.success)
    }

    public static func warning() {
        notification.notificationOccurred(.warning)
    }

    public static func error() {
        notification.notificationOccurred(.error)
    }

    // MARK: - Convenience: Press Interaction Pattern

    /// Call on touch-down
    public static func pressDown() {
        prepareSoft()
        soft(intensity: 0.3)
    }

    /// Call on release
    public static func pressUp() {
        medium()
    }
}
