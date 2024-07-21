# PureNavigationPath

[![Version](https://img.shields.io/cocoapods/v/PureNavigationPath.svg?style=flat)](https://cocoapods.org/pods/PureNavigationPath)
[![License](https://img.shields.io/cocoapods/l/PureNavigationPath.svg?style=flat)](https://cocoapods.org/pods/PureNavigationPath)
[![Platform](https://img.shields.io/cocoapods/p/PureNavigationPath.svg?style=flat)](https://cocoapods.org/pods/PureNavigationPath)

SwiftUI is continuously improving, and with SwiftUI supporting iOS 16.0 and later, it offers `NavigationPath` which makes it easier for us to manage navigation and `pop` or `push` views. Although it has addressed some limitations of older versions, there are still some issues with popping back to a specific view and identifying the items currently inside the NavigationStack.

I have extended it in a way that is purely SwiftUI, using only what is available and writing it in the most basic way possible.

Now we can pop to any `View` in the `NavigationStack` based on the `Codable` objects we have `appended` to the `NavigationPath`.
Check out the demo video below and use it if it can help you in your project.

## Demo
<img src="Demo.gif" width="300"/>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 16.0 or later
- Swift 5+

## Installation
PureNavigationPath is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PureNavigationPath'
```
## Usage
### Declare
Create `NavigationStack` with `NavigationPath`
Declare the Destinations
```swift
NavigationStack(path: $path) {
    // ***
}
.navigationDestination(type: BookCategory.self, destination: { category in
    ViewB(category: category)
})
.navigationDestination(type: Book.self, destination: { book in
    ViewC(book: book)
})
.navigationDestination(type: String.self, destination: { path in
    ViewD(path: path)
})
.navigationDestination(type: Int.self, destination: { intPath in
    ViewE(intPath: intPath)
})
```
### Push to View
Push to destinations according to the type defined above by appending Codable to the path.
```swift
struct Book: Identifiable, Hashable, Codable {}
let book = Book() // Codable struct
path.append(book)

enum BookCategory: Identifiable, Hashable, Codable {}
let category = BookCategory() 
path.append(category)

let pathString = "examplePath"
path.append(pathString)

let pathInteger = 100
path.append(pathInteger)
```

## Pop a View
Dismiss top view of navigation
```swift
path.pop()
```

### Pop to a Specific View
Pop to any View based on the original codable appended.
```swift
path.popTo(item: book)
path.popTo(item: category)
path.popTo(item: "examplePath")
path.popTo(item: 100)
```

### Pop to Root
```swift
path.popToRoot()
```

### Get current navigation stack
```swift
print(path.resolvedItems())
```

## Author

hosituan, hosituan.work@gmail.com

## License

PureNavigationPath is available under the MIT license. See the LICENSE file for more info.
