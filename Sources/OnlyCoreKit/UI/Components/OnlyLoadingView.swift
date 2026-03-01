//
//  OnlyLoadingView.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 08/02/2026.
//

import SwiftUI


/// Custom Loading Spinner
///
/// Uses the Only logo with spinning components
public struct OnlyLoadingView: View {
    
    private var scale: Double
    
    public init(scale: Double = 1) {
        self.scale = scale
    }
    
    @State private var isRotating = false
    
    public var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 5)
                .rotation(Angle(degrees: 300))
                .frame(width: 5 * scale, height: 50 * scale)
                .foregroundStyle(OnlyAppColours.onlyLogoYellow)
            
            Circle()
                .trim(from: 0, to: 0.85)
                .stroke(OnlyAppColours.onlyLogoRed, lineWidth: 5 * scale)
                .frame(width: 50 * scale, height: 50 * scale)
                .rotationEffect(Angle(degrees: isRotating ? 360 : 0))
                .animation(
                    .linear(duration: 1)
                    .speed(0.6)
                    .repeatForever(autoreverses: false), value: isRotating
                )
                .onAppear {
                    isRotating = true
                }
            
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 5 * scale, height: 40 * scale)
                .offset(y: 5 * scale)
                .foregroundStyle(OnlyAppColours.onlyLogoBlue)
            
            RoundedRectangle(cornerRadius: 5)
                .rotation(Angle(degrees: 300))
                .offset(x: -9 * scale, y: -18 * scale)
                .frame(width: 5 * scale, height: 20 * scale)
                .foregroundStyle(OnlyAppColours.onlyLogoBlue)
            
            RoundedRectangle(cornerRadius: 5)
                .rotation(Angle(degrees: 60))
                .offset(x: 9 * scale, y: -18 * scale)
                .frame(width: 5 * scale, height: 20 * scale)
                .foregroundStyle(OnlyAppColours.onlyLogoBlue)
            
            RoundedRectangle(cornerRadius: 15 * scale)
                .rotation(Angle(degrees: 45))
                .stroke(OnlyAppColours.onlyLogoPurple, lineWidth: 5 * scale)
                .frame(width: 60 * scale, height: 60 * scale)
                .rotationEffect(Angle(degrees: isRotating ? -360 : 0))
                .animation(
                    .linear(duration: 1)
                    .speed(0.5)
                    .repeatForever(autoreverses: false), value: isRotating
                )
                .onAppear {
                    isRotating = true
                }
            
            
        }
    }
}

#Preview {
    OnlyLoadingView()
}
