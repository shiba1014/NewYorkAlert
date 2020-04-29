//
//  Copyright © 2020 Satsuki Hashiba. All rights reserved.
//  GitHub: https://github.com/shiba1014
//

import UIKit

/// A color palette for NewYorkButton.
/// These colors will be adjusted based on an app's user interface style.
public enum NewYorkDynamicColor {
    /// Light: #f44336, Dark: #e53935
    case red

    /// Light: #ff5722, Dark: #ff8a65
    case orange

    /// Light: #ffc107, Dark: #ffd54f
    case yellow

    /// Light: #4caf50, Dark: #81c784
    case green

    /// Light: #009688, Dark: #4db6ac
    case teal

    /// Light: #2196f3, Dark: #64b5f6
    case blue

    /// Light: #3f51b5, Dark: #7986cb
    case indigo

    /// Light: #9c27b0, Dark: #ba68c8
    case purple

    /// Light: #e91e63, Dark: #f06292
    case pink

    var uiColor: UIColor {
        switch self {
        case .red:      return getDynamicColor(.red)
        case .orange:   return getDynamicColor(.orange)
        case .yellow:   return getDynamicColor(.yellow)
        case .green:    return getDynamicColor(.green)
        case .teal:     return getDynamicColor(.teal)
        case .blue:     return getDynamicColor(.blue)
        case .indigo:   return getDynamicColor(.indigo)
        case .purple:   return getDynamicColor(.purple)
        case .pink:     return getDynamicColor(.pink)
        }
    }

    private func getDynamicColor(_ color: Color) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { trait in
                trait.userInterfaceStyle == .dark ? color.dark : color.light
            }
        }
        else {
            return color.light
        }
    }
}

private enum Color {
    /// #222222
    static let black = UIColor(hex: 0x222222)

    case red
    case orange
    case yellow
    case green
    case teal
    case blue
    case indigo
    case purple
    case pink

    var light: UIColor {
        switch self {
        case .red:      return UIColor(hex: 0xe53935)
        case .orange:   return UIColor(hex: 0xff5722)
        case .yellow:   return UIColor(hex: 0xffc107)
        case .green:    return UIColor(hex: 0x4caf50)
        case .teal:     return UIColor(hex: 0x009688)
        case .blue:     return UIColor(hex: 0x2196f3)
        case .indigo:   return UIColor(hex: 0x3f51b5)
        case .purple:   return UIColor(hex: 0x9c27b0)
        case .pink:     return UIColor(hex: 0xe91e63)
        }
    }

    var dark: UIColor {
        switch self {
        case .red:      return UIColor(hex: 0xf44336)
        case .orange:   return UIColor(hex: 0xff8a65)
        case .yellow:   return UIColor(hex: 0xffd54f)
        case .green:    return UIColor(hex: 0x81c784)
        case .teal:     return UIColor(hex: 0x4db6ac)
        case .blue:     return UIColor(hex: 0x64b5f6)
        case .indigo:   return UIColor(hex: 0x7986cb)
        case .purple:   return UIColor(hex: 0xba68c8)
        case .pink:     return UIColor(hex: 0xf06292)
        }
    }
}


extension NewYorkDynamicColor {
    enum Background {
        static let `default`: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor.secondarySystemBackground
            }
            else {
                return .white
            }
        }()

        static let sub: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor.tertiarySystemBackground
            }
            else {
                return .white
            }
        }()

        static let overlay = UIColor(white: 0, alpha: 0.5)

        static let separator: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor.separator
            }
            else {
                return UIColor(white: 0.9, alpha: 1)
            }
        }()

        static let highlighted: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor.systemGray5
            }
            else {
                return UIColor(white: 0.9, alpha: 1)
            }
        }()

        static func button(_ isHighlighted: Bool) -> UIColor {
            isHighlighted ? Background.highlighted : Background.default
        }
    }
}

extension NewYorkDynamicColor {
    enum Text {
        static let title: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor.label
            }
            else {
                return Color.black
            }
        }()

        static let message: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor.secondaryLabel
            }
            else {
                return UIColor.systemGray
            }
        }()
    }
}

extension NewYorkDynamicColor {
    enum Button {
        static let `default`:   UIColor = NewYorkDynamicColor.blue.uiColor
        static let destructive: UIColor = NewYorkDynamicColor.red.uiColor
        static let cancel:      UIColor = UIColor.systemGray
    }
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255
        let blue = CGFloat((hex & 0x0000FF) >> 0) / 255

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
