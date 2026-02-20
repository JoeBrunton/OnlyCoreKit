//
//  ScrollViewViewModel.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 20/02/2026.
//

import Foundation
import SwiftUI

public class ScrollViewViewModel {
    private var lastOffset: CGFloat = 0.0
    
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
