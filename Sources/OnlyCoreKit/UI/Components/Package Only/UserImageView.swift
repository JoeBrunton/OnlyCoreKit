//
//  UserImageView.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 20/03/2026.
//

import SwiftUI


/// A structure limited to this package to create a custom Image view using the cases of `UserImage`
///
/// - Parameters:
///     - image: `UserImage` representing the image to be used
///     - size: `CGFloat` representing the size of the image
///     - blur: `Binding<Bool>` representing whether to blur the image when editing
///
/// ## Usage
/// ``` swift
///UserImageView(image: vm.userImage,
///                 size: 90,
///                 blur: $vm.isEditing)
///.overlay {
///     if vm.isEditing {
///         PhotosPicker(selection: $vm.selectedImageItem, matching: .images) {
///             Image(systemName: "plus.app.fill")
///             .resizable()
///             .frame(width: 30, height: 30)
///             .scaledToFit()
///             .foregroundStyle(OnlyAppPalette.onlyLogoYellow)
///             .shadow(radius: 8)
///         }
///         .onChange(of: vm.selectedImageItem) {
///             vm.loadImage()
///         }
///     }
///}
/// ```
///
/// - Note: The image currently appears as a rectangle with a width 80% the size of the height
///
package struct UserImageView: View {
    
    let image: UserImage?
    var size: CGFloat = 90
    @Binding var blur: Bool

    package var body: some View {
        content
            .frame(width: size * 0.8, height: size)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .blur(radius: blur ? 3 : 0)
    }

    @ViewBuilder
    private var content: some View {
        switch image {
//        case .assetImage(let image) :
//                image
//                    .resizable()
//                    .scaledToFill()
        case .url(let string):
            if let url = URL(string: string) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        placeholder
                    case .success(let img):
                        img.resizable().scaledToFill()
                    case .failure:
                        placeholder
                    @unknown default:
                        placeholder
                    }
                }
            } else {
                placeholder
            }

        case .data(let data):
            if let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                placeholder
            }

        case nil:
            placeholder
        }
    }

    private var placeholder: some View {
        ZStack {
            Color.gray.opacity(0.2)
            Image(systemName: "person.fill")
                .foregroundStyle(.gray)
        }
    }
}
