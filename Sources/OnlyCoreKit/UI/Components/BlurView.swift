//
//  BlurView.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 08/02/2026.
//

import SwiftUI
import UIKit


/// Centralised reference for the Edge of the screen to be used by the BlurView
public enum Edge {
    case top
    case bottom
    case all
}

/// Blurred Colour View that uses this to create fading colours at the top, bottom or both edges of the screen.
///
/// - Parameters:
///     - edge: `Edge`: the placement of the blur view
///     - colour:  `Color`: the colour of the blur view
///     - offCentre: `Binding<Bool>`: The offCentre bool allows for a leading focused top fade, it is a `Binding` variable to allow for more granular control over location - defaults to false
///
/// ## Usage
/// Use as the base of a `ZStack` to create a blurred colour background
///
/// ``` swift
///ZStack {
///     BlurView(edge:,
///             colour:,
///
///}
/// ```
///
/// - Note: the offCentre variable is intended for use with a scroll view phase change
///
public struct BlurView: View {
    
    public init(edge: Edge,
                colour: Color,
                offCentre: Binding<Bool> = .constant(false)) {
        self.edge = edge
        self.colour = colour
        self._offCentre = offCentre
    }
    
    private var edge: Edge = .all
    @Binding private var offCentre: Bool
    private var colour: Color = OnlyAppPalette.onlyLogoPurple
    
    let UIBackground = UIColor.systemBackground
    
    public var body: some View {
        
        VStack {
            switch edge {
            case .top:
                
                TopView(colour: colour, offCentre: $offCentre)
                
                Spacer()
                
            case .bottom:
                
                Spacer()
                
                LinearGradient(colors: [
                    Color(uiColor: UIBackground),
                    Color(uiColor: UIBackground),
                    .clear
                ], startPoint: .bottom, endPoint: .top)
                .frame(height: 150)
                
            case .all:
                
                TopView(colour: colour, offCentre: $offCentre)
                
                Spacer()
                
                if !offCentre {
                    LinearGradient(colors: [
                        Color(uiColor: UIBackground),
                        Color(uiColor: UIBackground).opacity(0.8),
                        .clear
                    ], startPoint: .bottom, endPoint: .top)
                    .frame(height: 150)
                }
            }
        }.ignoresSafeArea(.all)
            .onTapGesture {
                withAnimation {
                    offCentre.toggle()
                }
            }
    }
}


/// Extraction of top view with passed colour and binding off centre parameter
struct TopView: View {

    internal init(colour: Color = .accentColor, offCentre: Binding<Bool> = .constant(false)) {
        self.colour = colour
        self._offCentre = offCentre
    }
    
    
    private var colour: Color = .accentColor
    @Binding private var offCentre: Bool
    
    var body: some View {
        
        LinearGradient(colors: [colour, colour.opacity(0.5), .clear],
                       startPoint: offCentre ? .topLeading : .top,
                       endPoint: offCentre ? .bottomTrailing : .bottom)
        .frame(maxHeight: offCentre ? .infinity : 150)
    }
}


#Preview {
    @Previewable @State var bool: Bool = false
    BlurView(edge: .all, colour: OnlyAppPalette.onlyLogoPurple, offCentre: $bool)
        .onTapGesture {
            bool.toggle()
        }
}
