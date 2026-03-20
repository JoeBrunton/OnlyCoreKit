//
//  ScrollViewViewModel.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 20/02/2026.
//

import Foundation
import SwiftUI

/// A custom view model for handling scroll view dependent logic
///
/// - Parameters:
///     - lastOffset: `CGOffset`
///
/// ## Usage
///
/// `handleScrollBlur`: Intended to monitor the position of the scroll view and adjust the blur background accordingly.
/// Doesn't work super well at the moment.
/// ``` swift
///.onScrollPhaseChange { oldPhase, newPhase, context in
/// withAnimation {
///     scrolling = svvm.handleScrollBlur(offsetY: context.geometry.contentOffset.y,
///                                       phase: newPhase)
///     }
///     // scrolling can now be used in the $offCentre variable of BlurView
///}
/// ```
///
///
public class ScrollViewViewModel {
    private var lastOffset: CGFloat
    
    public init() {
        self.lastOffset = -60.0
    }
    
    public func handleScrollBlur(offsetY: CGFloat, phase: ScrollPhase) -> Bool {
        if phase == .interacting {
            lastOffset = offsetY
        }
        
        if phase == .idle || phase == .decelerating {
            return lastOffset > -60.0 ? false : !(phase == .interacting)
        }
        
        return !(phase == .interacting)
    }
}
