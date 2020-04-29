//
//  Copyright © 2020 Satsuki Hashiba. All rights reserved.
//  GitHub: https://github.com/shiba1014
//

import UIKit

/// A button for the NewYorkAlert.
public final class NewYorkButton: UIButton {

    // MARK: Constant

    private enum Const {
        static let fontSize: CGFloat = 14
        static let buttonHeight: CGFloat = 55
        static let animationDuration: TimeInterval = 0.2
    }

    // MARK: Private / Internal

    let style: Style
    let handler: ((NewYorkButton) -> Void)?

    private var titleColor: UIColor? {
        get {
            titleColor(for: .normal)
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }

    // MARK: Public

    /// Styles to apply to buttons in the NewYorkAlert.
    public enum Style {
        /// Default style.
        case `default`

        /// Style that indicates the action cancels the operation and leaves things unchanged.
        case cancel

        /// Style that indicates the action might change or delete data.
        case destructive

        /// Style that indicates the preferred action for the user to take.
        case preferred
    }

    /// A Boolean value indicating whether the control draws a highlight.
    /// Highlight animation will be performed here.
    override public var isHighlighted: Bool {
        didSet {
            performHighlight(isHighlighted)
        }
    }

    // MARK: - Initializers

    /// Creates a button that can be added to the NewYorkAlert.
    ///
    /// - Parameters:
    ///   - title: A button title.
    ///   - style: A style that is applied to the button.
    ///   - handler: A block to execute when the user taps the button.
    ///
    /// - Returns: A NewYorkButton object.
    public init(title: String, style: Style, handler: ((NewYorkButton) -> Void)? = nil) {
        self.style = style
        self.handler = handler
        super.init(frame: .zero)
        setup(title: title, style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public method

    /// Set button's title color from `NewYorkDynamicColor`.
    ///
    /// - Parameter color: A color to apply to the button's title
    public func setDynamicColor(_ color: NewYorkDynamicColor) {
        titleColor = color.uiColor
    }

    // MARK: - Private method

    private func setup(title: String, style: Style) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: Const.buttonHeight).isActive = true

        setTitle(title, for: .normal)

        switch style {
        case .default:
            titleLabel?.font = UIFont.systemFont(ofSize: Const.fontSize)
            titleColor = NewYorkDynamicColor.Button.default

        case .cancel:
            titleLabel?.font = UIFont.systemFont(ofSize: Const.fontSize)
            titleColor = NewYorkDynamicColor.Button.cancel

        case .destructive:
            titleLabel?.font = UIFont.systemFont(ofSize: Const.fontSize)
            titleColor = NewYorkDynamicColor.Button.destructive

        case .preferred:
            titleLabel?.font = UIFont.boldSystemFont(ofSize: Const.fontSize)
            titleColor = NewYorkDynamicColor.Button.default

        }
    }

    private func performHighlight(_ isHighlighted: Bool) {
        UIView.animate(withDuration: Const.animationDuration) { [weak self] in
            self?.backgroundColor = NewYorkDynamicColor.Background.button(isHighlighted)
        }
    }
}
