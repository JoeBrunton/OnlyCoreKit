//
//  ReuseButtonView.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 20/02/2026.
//

import SwiftUI

/// Reusable button view
///
/// This view contains several parameters for the customisation of the button.
/// This includes:
///
/// text: String?
///
/// image: Image?
///
/// isCenter: Bool (which defaults to true, pushing content to centre and pushes content left when false)
///
/// foreColour: Color (defaults to background colour)
///
/// backColour: Color (defaults to green)
///
/// width: CGFloat (defaults to infinity)
///
/// height: CGFloat (defaults to 60)
///
/// padding: CGFloat (defaults to 18 and refers to padding around button)
///
/// opacity: Double (defaults to 1)
///
public struct ReuseButtonView: View {
    
    private var text: String? = nil
    private var bold: Bool = false
    private var image: Image? = nil
    private var isCentre: Bool = true
    private var foreColour: Color = OnlyAppColours.onlyPaletteBackground
    private var backColour: Color = OnlyAppColours.onlyPaletteSuccess
    private var width: CGFloat = CGFloat.infinity
    private var height: CGFloat = 60
    private var padding: CGFloat = 18
    private var opacity: Double = 1
    
    public init(text: String? = nil,
                bold: Bool = false,
                image: Image? = nil,
                isCentre: Bool = true,
                foreColour: Color = OnlyAppColours.onlyPaletteBackground,
                backColour: Color = OnlyAppColours.onlyPaletteSuccess,
                width: CGFloat = CGFloat.infinity,
                height: CGFloat = 60,
                padding: CGFloat = 18,
                opacity: Double = 1) {
        self.text = text
        self.bold = bold
        self.image = image
        self.isCentre = isCentre
        self.foreColour = foreColour
        self.backColour = backColour
        self.width = width
        self.height = height
        self.padding = padding
        self.opacity = opacity
    }
    
    
    public var body: some View {
        HStack {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(.leading, text == nil
                             ? isCentre ? 0 : 25
                             : isCentre ? 18 : 25)
                    .padding(.trailing, text == nil ? 0 : 8)
            }
            
            if let t = text {
                Text(t)
                    .bold(bold)
                    .padding(image != nil ? [.vertical, .trailing] : .all)
                    .foregroundStyle(foreColour)
            }
            
            if !isCentre {
                Spacer()
            }
        }
        .frame(maxWidth: width, maxHeight: height)
        .background(backColour.opacity(opacity))
        .clipShape(.buttonBorder)
        .padding(padding)
    }
}

#Preview {
    ReuseButtonView(text: "push", image: LOGOs.onlyDefaultLogo, isCentre: false)
}
