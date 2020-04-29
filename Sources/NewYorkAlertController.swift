//
//  Copyright © 2020 Satsuki Hashiba. All rights reserved.
//  GitHub: https://github.com/shiba1014
//

import UIKit

/// Create an alert similar to UIAlertController
public final class NewYorkAlertController: UIViewController {

    // MARK: Private

    private enum Const {
        static let textFieldHeight: CGFloat = 32
        static let keyboardMargin: CGFloat = 16
    }

    private let style: Style
    private let alertView: NewYorkAlertViewType

    private var buttons: [NewYorkButton] = []
    private var tapDismissalGesture: UITapGestureRecognizer!

    private var cancelButton: NewYorkButton? {
        didSet {
            if oldValue != nil {
                fatalError("NewYorkAlert can only have one button with a style of NewYorkAlert.ActionStyle.cancel")
            }
        }
    }

    private var image: UIImage? {
        didSet {
            if oldValue != nil {
                fatalError("NewYorkAlert can only have one image")
            }
            else {
                alertView.addImage(image)
            }
        }
    }

    // MARK: Public

    /// Styles indicating the type of NewYorkAlert to display.
    public enum Style {
        /// An action sheet displayed in the context of the view controller that presented it.
        case actionSheet

        /// An alert displayed modally for the app.
        case alert
    }

    /// Indicates if alert can be dismissed via background tap.
    public var isTapDismissalEnabled: Bool = true {
        willSet {
            tapDismissalGesture.isEnabled = newValue
        }
    }

    /// The array of text fields displayed by the alert.
    public private(set) var textFields: [UITextField] = []

    // MARK: - Initializers

    /// Creates a standard NewYorkAlert with title, message and style.
    ///
    /// - Parameters:
    ///   - title: A title of alert.
    ///   - message: A message of alert.
    ///   - style: A style of alert to display.
    ///
    /// - Returns: A NewYorkAlertController object.
    public init(title: String?, message: String?, style: Style) {
        self.style = style
        switch style {
        case .actionSheet:
            alertView = ActionSheetView(title: title, message: message)
        case .alert:
            alertView = AlertView(title: title, message: message)
        }

        super.init(nibName: nil, bundle: nil)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View life cycle

    /// Called when the view is about to made visible.
    /// Buttons and text fields will be actually added to NewYorkAlert here.
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareForShow()
    }

    // MARK: - Public method

    /// Adds a button to the NewYorkAlert.
    ///
    /// - Note:
    /// If the button's style is `NewYorkButton.Style.cancel`,
    /// the button will always be added to the bottom of the NewYorkAlert.
    /// If the number of buttons added to the NewYorkAlert is two
    /// and the `style` property is set to `NewYorkAlertController.Style.alert`,
    /// buttons will be displayed horizontally and the cancel button will be displayed
    /// on the left.
    ///
    /// - Parameter button: A button to be added to the NewYorkAlert.
    public func addButton(_ button: NewYorkButton) {
        button.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)

        if button.style == .cancel {
            cancelButton = button
        }
        else {
            buttons.append(button)
        }
    }

    /// Adds buttons to the NewYorkAlert.
    ///
    /// - Note:
    /// If the button's style is `NewYorkButton.Style.cancel`,
    /// the button will always be added to the bottom of the NewYorkAlert.
    /// If the number of buttons added to the NewYorkAlert is two
    /// and the `style` property is set to `NewYorkAlertController.Style.alert`,
    /// buttons will be displayed horizontally and the cancel button will be displayed
    /// on the left.
    ///
    /// - Parameter buttons: An array of buttons to be added to the NewYorkAlert.
    public func addButtons(_ buttons: [NewYorkButton]) {
        buttons.forEach { addButton($0) }
    }

    /// Adds a text field to the NewYorkAlert.
    ///
    /// - Note:
    /// You can add a text field only if the `style` property is set
    /// to `NewYorkAlertController.Style.alert`.
    ///
    /// - Parameter configurationHandler: A block for configuring the text field
    ///                                   prior to displaying the NewYorkAlert.
    public func addTextField(configurationHandler: ((UITextField) -> Void)? = nil) {
        let textField = LeftPaddingTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.heightAnchor.constraint(equalToConstant: Const.textFieldHeight).isActive = true
        configurationHandler?(textField)

        textFields.append(textField)
    }

    /// Adds an image to the NewYorkAlert.
    ///
    /// - Note: You can add only one image to the NewYorkAlert.
    ///
    /// - Parameter image: An image to be added to the NewYorkAlert
    public func addImage(_ image: UIImage?) {
        self.image = image
    }

    // MARK: - Private method

    private func setupViews() {
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen

        tapDismissalGesture = UITapGestureRecognizer(target: self, action: #selector(tappedView(_:)))
        tapDismissalGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapDismissalGesture)

        view.backgroundColor = NewYorkDynamicColor.Background.overlay
        view.addSubview(alertView)

        switch style {
        case .actionSheet:
            NSLayoutConstraint.activate([
                alertView.leftAnchor.constraint(equalTo: view.leftAnchor),
                alertView.rightAnchor.constraint(equalTo: view.rightAnchor),
                alertView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])

        case .alert:
            NSLayoutConstraint.activate([
                alertView.leftAnchor.constraint(equalTo: view.leftAnchor),
                alertView.rightAnchor.constraint(equalTo: view.rightAnchor),
                alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }

    private func prepareForShow() {
        alertView.addButtons(buttons, cancelButton: cancelButton)
        if !textFields.isEmpty {
            alertView.addTextFields(textFields)
        }

        // Register notification
        if !textFields.isEmpty {
            let notification = NotificationCenter.default
            notification.addObserver(
                self,
                selector: #selector(keyboardWillShow(_:)),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
        }
    }

    @objc private func tappedView(_ tap: UITapGestureRecognizer) {
        let location = tap.location(in: alertView)
        if alertView.isBackgroundTap(point: location) {
            dismiss(animated: true, completion: nil)
        }
    }

    @objc private func tappedButton(_ button: NewYorkButton) {
        dismiss(animated: true) {
            button.handler?(button)
        }
    }

    @objc func keyboardWillShow(_ notification: Notification?) {
        guard let keyboardSize = (notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let keyboardMinY = view.bounds.height - keyboardSize.height
        let coverd = (alertView.frame.maxY + Const.keyboardMargin) - keyboardMinY
        if coverd > 0 {
            view.frame = CGRect(
                x: 0,
                y: 0 - coverd,
                width: view.bounds.width,
                height: view.bounds.height
            )
        }
    }
}
