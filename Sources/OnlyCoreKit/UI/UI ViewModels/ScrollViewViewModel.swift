//
//  File.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 20/02/2026.
//

import Foundation
import SwiftUI

class ScrollViewViewModel {
    private var lastOffset: CGFloat = -60.0
    
    func handleScrollBlur(offsetY: CGFloat, phase: ScrollPhase) -> Bool {
        if phase == .interacting {
            lastOffset = offsetY
        }
        
        if phase == .idle || phase == .decelerating {
            return lastOffset > -60.0 ? false : !(phase == .interacting)
        }
        
        return !(phase == .interacting)
    }
}
