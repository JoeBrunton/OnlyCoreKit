//
//  BlurView.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 08/02/2026.
//

import SwiftUI
import UIKit

public enum Edge {
    case top
    case bottom
    case all
}

/// Blurred Colour View
///
/// Takes in an edge and colour parameter.
///
/// It uses this to create fading colours at the top, bottom or both edges of the screen.
///
/// The offCentre bool allows for a leading focused top fade,
/// it is a @Binding variable to allow for more granular control over location
///
public struct BlurView: View {
    
    public init(edge: Edge, colour: Color, offCentre: Binding<Bool>) {
        self.edge = edge
        self.colour = colour
        self._offCentre = offCentre
    }
    
    public var edge: Edge = .all
    @Binding public var offCentre: Bool
    public var colour: Color = OnlyAppColours.onlyLogoPurple
    
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
    
    var colour: Color = .accentColor
    @Binding var offCentre: Bool
    
    var body: some View {
        
        LinearGradient(colors: [
            colour,
            colour.opacity(0.5),
                .clear
        ],
                       startPoint: offCentre ? .topLeading : .top,
                       endPoint: offCentre ? .bottomTrailing : .bottom)
        .frame(height: offCentre ? .infinity : 150)
    }
}

#Preview {
    @Previewable @State var bool: Bool = false
    BlurView(edge: .all, colour: OnlyAppColours.onlyLogoPurple, offCentre: $bool)
        .onTapGesture {
            bool.toggle()
        }
}
