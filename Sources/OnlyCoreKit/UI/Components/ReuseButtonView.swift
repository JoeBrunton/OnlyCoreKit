//
//  ReuseButtonView.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 20/02/2026.
//

import SwiftUI

public struct ReuseButtonView: View {
    
    private var text: String? = nil
    private var bold: Bool = false
    private var image: Image? = nil
    private var isCentre: Bool = true
    private var foreColour: Color = .white
    private var backColour: Color = OnlyAppColours.onlyPaletteSuccess
    private var width: CGFloat = CGFloat.infinity
    private var height: CGFloat = 60
    private var padding: CGFloat = 18
    private var opacity: Double = 1
    
    public init(text: String? = nil,
                bold: Bool = false,
                image: Image? = nil,
                isCentre: Bool = true,
                foreColour: Color = Color.white,
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
                    .padding(.trailing, 8)
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
