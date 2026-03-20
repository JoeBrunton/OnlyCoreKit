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

## License
© Joelle Brunton (2026)
##
Contact: joellebrunton@gmail.com
