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
    
    public init() {}
    
    @State private var isRotating = false
    
    public var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 5)
                .rotation(Angle(degrees: 300))
                .frame(width: 5, height: 50)
                .foregroundStyle(OnlyAppColours.onlyLogoYellow)
            
            Circle()
                .trim(from: 0, to: 0.85)
                .stroke(OnlyAppColours.onlyLogoRed, lineWidth: 5)
                .frame(width: 50, height: 50)
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
                .frame(width: 5, height: 40)
                .offset(y: 5)
                .foregroundStyle(OnlyAppColours.onlyLogoBlue)
            
            RoundedRectangle(cornerRadius: 5)
                .rotation(Angle(degrees: 300))
                .offset(x: -9, y: -18)
                .frame(width: 5, height: 20)
                .foregroundStyle(OnlyAppColours.onlyLogoBlue)
            
            RoundedRectangle(cornerRadius: 5)
                .rotation(Angle(degrees: 60))
                .offset(x: 9, y: -18)
                .frame(width: 5, height: 20)
                .foregroundStyle(OnlyAppColours.onlyLogoBlue)
            
            RoundedRectangle(cornerRadius: 10)
                .rotation(Angle(degrees: 45))
                .stroke(OnlyAppColours.onlyLogoPurple, lineWidth: 5)
                .frame(width: 60, height: 60)
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
