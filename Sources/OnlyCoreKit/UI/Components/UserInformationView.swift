//
//  SwiftUIView.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 18/03/2026.
//

import SwiftUI
import PhotosUI

struct UserGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

extension GroupBoxStyle where Self == UserGroupBoxStyle {
    static var user: UserGroupBoxStyle { .init() }
}

/// A reusable view for displaying and editing user information.
///
/// `UserInformationView` presents a user's profile details inside a `GroupBox`.
/// Tapping the view toggles between read-only and editable states.
///
/// The view is backed by ``UserInformationViewModel`` and supports optional
/// persistence via an injected save closure.
///
/// ## Features
/// - Displays user name, pronouns, date of birth, and image
/// - Supports inline editing of all fields
/// - Integrates with `PhotosPicker` for image selection
/// - Works without persistence by default
///
/// ## Usage
/// ```swift
/// UserInformationView(user: currentUser) { update in
///     try await userService.updateUser(update)
/// }
/// ```
///
/// ## Editing Behaviour
/// - Tap the view to enter editing mode
/// - Modify fields as needed
/// - Tap "Update" to commit changes
/// - Tap "Cancel" to discard changes
///
/// - Note: If no `onSave` closure is provided, changes will not persist.
public struct UserInformationView: View {
    
    public init(user: any UserProtocol, onSave: @escaping (UserUpdateRequest) async throws -> Void = { _ in }) {
        _vm = State(wrappedValue: ViewModel(user: user, onSave: onSave))
    }
    
    @State private var vm: ViewModel
    
    public var body: some View {
        GroupBox {
            HStack(alignment: .top) {
                
                UserImageView(image: vm.userImage,
                              size: 90,
                              blur: $vm.isEditing)
                .overlay {
                    if vm.isEditing {
                        PhotosPicker(selection: $vm.selectedImageItem, matching: .images) {
                            Image(systemName: "plus.app.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                                .foregroundStyle(OnlyAppPalette.onlyLogoYellow)
                                .shadow(radius: 8)
                        }
                        .onChange(of: vm.selectedImageItem) {
                            vm.loadImage()
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    
                    if vm.isEditing {
                        TextField("Enter Username", text: $vm.name)
                            .textFieldStyle(.roundedBorder)
                    } else {
                        Text(vm.name)
                            .bold()
                    }
                    
                    HStack {
                        Text("Pronouns: ")
                        
                        if !vm.isEditing {
                            Text(vm.pronouns.pronoun)
                                .padding(3)
                                .padding(.horizontal)
                                .foregroundStyle(Color(uiColor: Utilities.UIColorFromHexRGB(rgbValue: vm.pronouns.foregroundRGB)))
                                .background(Color(uiColor: Utilities.UIColorFromHexRGB(rgbValue: vm.pronouns.backgroundRGB)))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        
                        Spacer()
                    }
                    
                    if vm.isEditing {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                        ]) {
                            ForEach(vm.pronounsArray) { pronoun in
                                Button {
                                    if vm.pronouns.id != pronoun.id {
                                        vm.pronouns = pronoun
                                    }
                                } label: {
                                    ReuseButtonView(text: pronoun.pronoun,
                                                    foreColour: Color(uiColor: Utilities.UIColorFromHexRGB(rgbValue: pronoun.foregroundRGB)),
                                                    backColour: Color(uiColor: Utilities.UIColorFromHexRGB(rgbValue: pronoun.backgroundRGB)),
                                                    padding: 0,
                                                    opacity: vm.pronouns.id == pronoun.id ? 1 : 0.4 )
                                    .shadow(radius: vm.pronouns.id == pronoun.id ? 5 : 0)
                                }
                            }
                        }
                    }
                    
                    if vm.isEditing {
                        DatePicker("Date of Birth:", selection: $vm.dob, displayedComponents: .date)
                            .datePickerStyle(.automatic)
                    } else {
                        Text("Age: \(Utilities.age(from: vm.dob)) years")
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            if vm.isEditing {
                HStack {
                    Button {
                        withAnimation(.bouncy) {
                            vm.cancel()
                        }
                    } label: {
                        ReuseButtonView(text: "Cancel",
                                        foreColour: .white,
                                        backColour: OnlyAppPalette.onlyPaletteError,
                                        padding: 0)
                    }
                    
                    Button {
                        Task { await vm.save() }
                    } label: {
                        ReuseButtonView(text: "Update",
                                        foreColour: .white,
                                        backColour: OnlyAppPalette.onlyPaletteSuccess,
                                        padding: 0)
                    }
                }.padding(.top, 20)
            }
        }
        .groupBoxStyle(.user)
        .onTapGesture {
            withAnimation(.bouncy) {
                vm.isEditing = true
            }
        }
    }
}

struct exampleUser: UserProtocol {
    var id = UUID()
    var name: String
    var pronouns: Pronoun
    var dob: Date
    var image: UserImage?
}

#Preview {
    UserInformationView(user: exampleUser(name: "Joelle",
                                          pronouns: Pronoun.sheHer,
                                          dob: Date()))
}
