# OnlyCoreKit 📦

OnlyCoreKit is a swift package with essential views and extensions for Only apps. It contains a mixture of SwiftUI views including BlurView that provides a characteristic colour fade for use in ZStacks as well as OnlyLoadingView an Only specific spinner. Also included are asset catalogues for colours and logos.

## Installation

Use the [Swift Package Manager](https://docs.swift.org/swiftpm/documentation/packagemanagerdocs/) with the GitHub [link](https://github.com/JoeBrunton/OnlyCoreKit.git) for the project 

## Usage

```swift
import OnlyCoreKit

// Using logo colours
view.foregroundStyle(OnlyAppColours.onlyLogoRed)

// Blur view placed behind view content
ZSTack {
  BlurView(edge: .top)
  VStack {...}
}
```

## 🔥 Firebase Usage

OnlyCoreKit provides authentication and Firestore helpers, but **it does not configure Firebase for you**.

This package assumes that:

- Firebase has been added to the host application
- `GoogleService-Info.plist` exists in the app target
- `FirebaseApp.configure()` is called during app launch

---

### 1️⃣ Add Firebase to Your App Target

Add Firebase via Swift Package Manager or CocoaPods to your **application target**, not OnlyCoreKit.

Minimum required modules:

- `FirebaseAuth`
- `FirebaseFirestore`
- `FirebaseFirestoreSwift`

---

### 2️⃣ Configure Firebase in Your App

In your `App` entry point:

```swift
import SwiftUI
import Firebase

@main
struct MyApp: App {

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

## License
© Joelle Brunton (2026)
##
Contact: joellebrunton@gmail.com
