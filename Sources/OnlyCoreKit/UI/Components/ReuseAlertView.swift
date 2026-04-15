//
//  ReuseAlertView.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 08/04/2026.
//

import SwiftUI

private struct ExampleAlert: AlertProtocol {
    var id: UUID = UUID()
    var alertType: AlertType = .actionAndCancel
    var title: String = "Alert title"
    var description: String? = "This is the alert description.. etc. etc."
    var image: Image? = nil
    var userInputPlaceholder: String? = nil
}


/// Custom alert view using an `AlertProtocol` object
///
/// Use this custom alert view above your `ZSTack` with it's appearance based on a `@State  ` `(any AlertProtocol)? = nil`
///
/// - Parameters:
///     - alert: `any AlertProtocol`
///     - height: `CGFloat`
///     - isLogoShown: `Bool` defualts to true showing the transparent only logo in the corner.
///     - onAction(String?): `-> Void` which can return a `String` that could contain the user input, for example.
///     - onCancel(): `-> Void` use to set the alert as nil to return to original client view state.
///     - public init(alert):
///
/// - Note: use onCancel to set the alert State to nil again to dismiss
public struct ReuseAlertView: View {
    
    private var alert: any AlertProtocol
    private var height: CGFloat
    private var isLogoShown: Bool
    private var onAction: (String?) -> Void
    private var onCancel: () -> Void
    private var okayButtonText: String
    
    @State var userInput: String = ""
    
    public init(alert: any AlertProtocol,
                height: CGFloat = 400,
                isLogoShown: Bool = true,
                onAction: @escaping (String?) -> Void = { _ in },
                onCancel: @escaping () -> Void = { },
                okayButtonText: String = "okay") {
        self.alert = alert
        self.height = height
        self.isLogoShown = isLogoShown
        self.onAction = onAction
        self.onCancel = onCancel
        self.okayButtonText = okayButtonText
    }
    
    public var body: some View {
        ZStack {
            Color(.lightGray)
                .ignoresSafeArea()
                .blur(radius: 5)
            VStack {
                Text(alert.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                
                ScrollView {
                    if let desc = alert.description {
                        Text(desc)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    if let image = alert.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 150)
                    }
                    
                    if let placeholder = alert.userInputPlaceholder {
                        TextField(placeholder, text: $userInput)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                
                
                switch alert.alertType {
                case .actionOnly:
                    Button {
                        alert.userInputPlaceholder == nil
                        ? onAction(nil)
                        : onAction(userInput)
                    } label: {
                        ReuseButtonView(text: self.okayButtonText,
                                        bold: true,
                                        foreColour: .white,
                                        backColour: OnlyAppPalette.onlyPaletteSuccess,)
                    }
                case .cancelOnly:
                    Button {
                        onCancel()
                    } label: {
                        ReuseButtonView(text: "cancel",
                                        bold: true,
                                        foreColour: .white,
                                        backColour: OnlyAppPalette.onlyPaletteError,)
                    }
                case .actionAndCancel:
                    HStack(spacing: 0) {
                        Button {
                            onCancel()
                        } label: {
                            ReuseButtonView(text: "cancel",
                                            bold: true,
                                            foreColour: .white,
                                            backColour: OnlyAppPalette.onlyPaletteSuccess,
                                            padding: 5)
                        }
                        Button {
                            alert.userInputPlaceholder == nil
                            ? onAction(nil)
                            : onAction(userInput)
                        } label: {
                            ReuseButtonView(text: self.okayButtonText,
                                            bold: true,
                                            foreColour: .white,
                                            backColour: OnlyAppPalette.onlyPaletteError,
                                            padding: 5)
                        }
                    }
                case .destructive:
                    HStack(spacing: 0) {
                        Button {
                            onCancel()
                        } label: {
                            ReuseButtonView(text: "cancel",
                                            bold: true,
                                            foreColour: .black.opacity(0.6),
                                            backColour: .thinMaterial,
                                            padding: 5)
                        }
                        Button {
                            alert.userInputPlaceholder == nil
                            ? onAction(nil)
                            : onAction(userInput)
                        } label: {
                            ReuseButtonView(text: "delete",
                                            bold: true,
                                            foreColour: .white,
                                            backColour: OnlyAppPalette.onlyPaletteError,
                                            padding: 5)
                        }
                    }
                }
            }
            .padding()
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 5)
            .padding()
            .frame(height: height)
            
            VStack {
                HStack {
                    Spacer()
                    LOGOs.onlyLogoTransparent
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .shadow(radius: 3)
                }
                .padding(.horizontal, 5)
                Spacer()
            }
            .frame(height: height)
        }
    }
}

#Preview {
    ReuseAlertView(alert: ExampleAlert())
}
