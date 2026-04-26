//
//  MessageView.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 01/03/2026.
//

import SwiftUI


/// Centralised reference for the position of a `MessageView` in a `HSTack`
public enum MessagePosition {
    case left
    case right
}

/// A reusable view for in app messaging presentation.
///
/// - Parameters:
///     - text: `String`: the message to be displayed
///     - position: ``MessagePosition``: the position in the `HStack` - left or right
///     - opacity: `Binding<Double?>`: the opacity of the background of the message - defaults to 1.0
///     - textColour: `Color`: the text colour - defaults to `OnlyAppPalette.onlyPaletteLabel`
///     - backColour: `Color`: the background colour of the message - defaults to `OnlyAppPalette.onlyPaletteBackground`
///     - radius: `CGFloat`: the corner radius of the background of the message - defaults to 12
///     - shadow: `CGFloat`: the shadow of the background of the message - defaults to 0
///     - isLoading: `Bool`: tag to show if the message is currently loading - defaults to false
///
/// - Important: make sure to set the backColour different for a user message and a received message
///
/// ## Usage
/// ``` swift
///ForEach(messages) { message in
///     MessageView(text: message.text,
///                 position: message.ownerID == userID ? .right : .left,
///                 opacity: $opacity,
///                 backColour: message.ownerID == userID ? .gray : .darkGray)
///}
/// ```
///
/// - Note: when using `MessageView` for currently typing text, the text parameter can be left empty or, alternatively, the isLoading parameter set to true:
/// ``` swift
///MessageView(position: .left ....)
///
///// alternatively:
///MessageView(text: "this won't appear",
///            position: .left,
///            opacity: $opac,
///            isLoading: true)
/// ```
///
public struct MessageView: View {
    
    public init(text: String = "",
                position: MessagePosition,
                opacity: Binding<Double> = .constant(1.0),
                textColour: Color = OnlyAppPalette.onlyPaletteLabel,
                backColour: Color = OnlyAppPalette.onlyPaletteBackground,
                radius: CGFloat = 12,
                shadow: CGFloat = 0,
                isLoading: Bool = false,
                isRead: Bool = false,
                timestamp: Date) {
        self.text = text
        self.position = position
        self._opacity = opacity
        self.textColour = textColour
        self.backColour = backColour
        self.radius = radius
        self.shadow = shadow
        self.isLoading = text.isEmpty || isLoading
        self.isRead = isRead
        self.timestamp = timestamp
    }
    
    private var text: String
    private var position: MessagePosition
    @Binding private var opacity: Double
    private var textColour: Color
    private var backColour: Color
    private var radius: CGFloat
    private var shadow: CGFloat
    private var isLoading: Bool
    private var isRead: Bool
    private var timestamp: Date
    
    @State private var bounce: Bool = false
    
    public var body: some View {
        HStack {
            if position == .right {
                Spacer()
            }
                        
            
            HStack(alignment: .bottom) {
                if position == .left {
                    VStack {
//                        TicksView(isRead: isRead)
                        Text(timestamp.timeString)
                            .font(.subheadline)
                            .fontWeight(.ultraLight)
                    }
                }
                
                Text(isLoading ? "..." : text)
                    .foregroundStyle(textColour)
                    .font(.subheadline)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: radius)
                            .foregroundStyle(backColour)
                            .opacity(opacity)
                            .shadow(radius: shadow)
                    }
                    .frame(maxWidth: 300, alignment: position == .left ? .leading : .trailing)
                
                if position == .right {
                    VStack {
                        TicksView(isRead: isRead)
                        Text(timestamp.timeString)
                            .font(.subheadline)
                            .fontWeight(.ultraLight)
                    }
                }
            }
            
            
            if position == .left {
                Spacer()
            }
        }
        .offset(CGSize(width: 0, height: bounce ? 3 : 0))
        .onAppear {
            if isLoading {
                withAnimation(.bouncy.repeatForever()) {
                    bounce.toggle()
                }
            }
        }
    }
    
    struct TicksView: View {
        
        var isRead: Bool = false
        
        var body: some View {
            if isRead {
                Image(systemName: "checkmark.message.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundStyle(OnlyAppPalette.onlyLogoBlue)
            } else {
                Image(systemName: "checkmark.message")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundStyle(OnlyAppPalette.onlyLogoBlue)
            }
        }
    }
}

#Preview {
    
    MessageView(text: "hi",
                position: .left,
                shadow: 5,
                timestamp: Date())
    .padding(.horizontal)
    
}
