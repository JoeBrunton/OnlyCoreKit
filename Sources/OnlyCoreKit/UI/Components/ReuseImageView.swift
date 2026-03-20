//
//  ReuseImageView.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 15/03/2026.
//

import SwiftUI

/// A reusable image view with configurable sizing, corner radius, shadow, and optional border.
///
/// `ReuseImageView` wraps a named image asset and applies common visual treatments
/// in a single, composable SwiftUI view. It is intended for use across multiple
/// screens where consistent image styling is required.
///
/// ## Usage
/// Use `ReuseImageView` when you need a styled image with rounded corners and an
/// optional coloured border. The view scales the image to fill the given frame
/// and clips it to a rounded rectangle.
///
/// ```swift
/// ReuseImageView(
///     imageName: "profile_photo",
///     width: 80,
///     height: 80,
///     radius: 40,
///     shadow: 4,
///     borderColour: .blue,
///     borderWidth: 2
/// )
/// ```
public struct ReuseImageView: View {
    
    public init(imageName: String, width: CGFloat = 100, height: CGFloat = 100, radius: CGFloat = 15, shadow: CGFloat = 0, aspect: ContentMode = .fill, borderColour: Color? = nil, borderWidth: CGFloat? = nil) {
        self.imageName = imageName
        self.width = width
        self.height = height
        self.radius = radius
        self.shadow = shadow
        self.aspect = aspect
        self.borderColour = borderColour
        self.borderWidth = borderWidth
    }
    
    
    private var imageName: String
    private var width: CGFloat = 100
    private var height: CGFloat = 100
    private var radius: CGFloat = 15
    private var shadow: CGFloat = 0
    private var aspect: ContentMode = .fill
    private var borderColour: Color?
    private var borderWidth: CGFloat?
    
    public var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: aspect)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: radius))
            .shadow(radius: shadow)
            .overlay {
                if let bc = borderColour, let bw = borderWidth {
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(bc, lineWidth: bw)
                }
            }
    }
}

#Preview {
//    ReuseImageView(borderColour: .purple, borderWidth: 2)
}
