//
//  ReuseButtonView.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 20/02/2026.
//

import SwiftUI

/// Reusable button view
///
/// - Parameters:
///     - text: `String`? the text to be displayed on the button - defaults to nil
///     - bold: `Bool`: a tag to determine whether button text should be bold - defaults to false
///     - image: `Image`? an optional image to include in the button - defaults to nil
///     - isCenter: `Bool`: a tag to determine where content should be placed in button view - defaults to true, pushing content to centre and pushes content leading when false
///     - foreColour: `Color`: the foreground colour of the button - defaults to background colour
///     - backColour: `Background -> ShapeStyle`: the background style of the button - defaults to green but can be a linear gradient
///     - width: `CGFloat`: the width of the button - defaults to infinity
///     - height: `CGFloat`: the height of the button - defaults to 60
///     - padding: `CGFloat`:  the padding around the button - defaults to 18
///     - opacity: `Double`: The opacity of the button background - defaults to 1
///     - borderColour: `Color`: The colour of the overlay Rectangle stroke - defaults to `OnlyAppPalette.label`
///     - borderWidth: `CGFloat`: The width of the overlay Rectangle stroke - defaults to 0
///
/// ## Usage
///
/// ``` swift
///Button {
/// // sign in logic
///} label: {
/// ReuseButtonView(text: "Sign in with Apple",
///                    image: LOGOs.AppleDark,
///                    isCentre: false)
///}
/// ```
///
/// when toggling selection:
/// ``` swift
///Button {
/// selection.toggle()
///} label: {
///ReuseButtonView(...
///                 borderWidth: selection ? 2 : 0)
/// ```
///
public struct ReuseButtonView<Background: ShapeStyle>: View {
    
    private var text: String? = nil
    private var bold: Bool = false
    private var image: Image? = nil
    private var isCentre: Bool = true
    private var foreColour: Color = OnlyAppPalette.onlyPaletteBackground
    private var backColour: Background
    private var width: CGFloat = CGFloat.infinity
    private var height: CGFloat = 60
    private var padding: CGFloat = 18
    private var opacity: Double = 1
    private var borderColour: Color
    private var borderWidth: CGFloat
    
    public init(text: String? = nil,
                bold: Bool = false,
                image: Image? = nil,
                isCentre: Bool = true,
                foreColour: Color = OnlyAppPalette.onlyPaletteBackground,
                backColour: Background = OnlyAppPalette.onlyPaletteSuccess,
                width: CGFloat = CGFloat.infinity,
                height: CGFloat = 60,
                padding: CGFloat = 18,
                opacity: Double = 1,
                borderColour: Color = OnlyAppPalette.onlyPaletteLabel,
                borderWidth: CGFloat = 0) {
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
        self.borderColour = borderColour
        self.borderWidth = borderWidth
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
                    .minimumScaleFactor(0.4)
                    .padding(image != nil ? [.vertical, .trailing] : .all)
                    .foregroundStyle(foreColour)
            }
            
            if !isCentre {
                Spacer()
            }
        }
        .overlay(content: {
            Rectangle()
                .stroke(borderColour, lineWidth: borderWidth)
                .clipShape(.buttonBorder)
        })
        .frame(maxWidth: width, maxHeight: height)
        .background(backColour.opacity(opacity))
        .clipShape(.buttonBorder)
        .padding(padding)
    }
}

#Preview {
    ReuseButtonView(text: "push", image: LOGOs.onlyDefaultLogo, isCentre: false)
}
