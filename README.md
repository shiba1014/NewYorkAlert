![Logo](https://github.com/shiba1014/NewYorkAlert/blob/master/Assets/logo.png?raw=true)


### **A modern alert and action sheet for iOS written in Swift.**

![Swift Version](https://img.shields.io/badge/Swift-5.1-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/NewYorkAlert.svg?style=flat)](http://cocoapods.org/pods/NewYorkAlert)
[![License](https://img.shields.io/cocoapods/l/NewYorkAlert.svg?style=flat)](http://cocoapods.org/pods/NewYorkAlert)
[![Platform](https://img.shields.io/cocoapods/p/NewYorkAlert.svg?style=flat)](http://cocoapods.org/pods/NewYorkAlert)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Introduction

NewYorkAlert is a modern alert and action sheet for iOS written in Swift.

|![Alert](https://github.com/shiba1014/NewYorkAlert/blob/master/Assets/alert.png?raw=true)|![ActionSheet](https://github.com/shiba1014/NewYorkAlert/blob/master/Assets/action_sheet.png?raw=true)|![TextFields](https://github.com/shiba1014/NewYorkAlert/blob/master/Assets/text_fields.png?raw=true)|![DarkMode](https://github.com/shiba1014/NewYorkAlert/blob/master/Assets/alert_dark.png?raw=true)|
|:----------------------------:|:------------------------:|:------------------------:|:----------------------:|


### Features

- [x] Modern design
- [x] Easy to add text fields and image
- [x] Support dark mode
- [x] Can be dismissed via background tap

## Requirements

- Swift 5.1
- iOS 11.0 or later

## Usage

[API Documentation](https://shiba1014.github.io/NewYorkAlert)

### Default Alert

```swift
let alert = NewYorkAlertController(title: "Title", message: "Message", style: .alert)

let ok = NewYorkButton(title: "OK", style: .default) { _ in
    print("Tapped OK")
}
let cancel = NewYorkButton(title: "Cancel", style: .cancel)

alert.addButton(ok)
alert.addButton(cancel)

present(alert, animated: true)
```

### Default Action Sheet

```swift
let actionSheet = NewYorkAlertController(title: "Title", message: "Message", style: .actionSheet)

let buttons = [
    NewYorkButton(title: "Apple", style: .default),
    NewYorkButton(title: "Orange", style: .default),
    NewYorkButton(title: "Lemon", style: .default),
]
actionSheet.addButtons(buttons)

present(actionSheet, animated: true)
```

### Text Fields (Only Alert)

```swift
let alert = NewYorkAlertController.init(title: "Title", message: "Message", style: .alert)

alert.addTextField { tf in
    tf.placeholder = "username"
    tf.tag = 1
}
alert.addTextField { tf in
    tf.placeholder = "password"
    tf.tag = 2
}

let ok = NewYorkButton(title: "OK", style: .default) { [unowned alert] _ in
    alert.textFields.forEach { tf in
        let text = tf.text ?? ""
        switch tf.tag {
        case 1:
            print("username: \(text)")
        case 2:
            print("password: \(text)")
        default:
            break
        }
    }
}
let cancel = NewYorkButton(title: "Cancel", style: .cancel)
alert.addButtons([ok, cancel])

present(alert, animated: true)
```

### Dark Mode

NewYorkAlert will automatically follow an app's user interface style.

|![Alert](https://github.com/shiba1014/NewYorkAlert/blob/master/Assets/alert_dark.png?raw=true)|![ActionSheet](https://github.com/shiba1014/NewYorkAlert/blob/master/Assets/action_sheet_dark.png?raw=true)|![TextFields](https://github.com/shiba1014/NewYorkAlert/blob/master/Assets/text_fields_dark.png?raw=true)|
|:----------------------------:|:------------------------:|:------------------------:|

## Installation

### [CocoaPods](https://cocoapods.org)
Add the following to your `Podfile`:
```ruby
pod 'NewYorkAlert'
```

### [Carthage](https://github.com/Carthage/Carthage)
Add the following to your `Cartfile`:
```
github "shiba1014/NewYorkAlert"
```
