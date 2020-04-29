//
//  Copyright © 2020 Satsuki Hashiba. All rights reserved.
//  GitHub: https://github.com/shiba1014
//

import UIKit

final class AlertView: UIView, NewYorkAlertViewType {

    // MARK: Constants

    private enum Const {
        enum ContentView {
            static let minMargin: CGFloat = 16
            static let maxWidth: CGFloat = 300
        }

        enum FontSize {
            static let title: CGFloat = 16
            static let message: CGFloat = 14
        }

        enum Spacing {
            static let large: CGFloat = 16
            static let small: CGFloat = 8
        }

        static let padding: CGFloat = 24
        static let cornerRadius: CGFloat = 5
        static let imageHeight: CGFloat = 150
    }

    // MARK: Views

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = NewYorkDynamicColor.Background.default
        view.layer.cornerRadius = Const.cornerRadius
        view.clipsToBounds = true
        return view
    }()

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Const.Spacing.large
        return stackView
    }()

    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Const.Spacing.small
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = NewYorkDynamicColor.Text.title
        label.font = .boldSystemFont(ofSize: Const.FontSize.title)
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = NewYorkDynamicColor.Text.message
        label.font = .systemFont(ofSize: Const.FontSize.message)
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let textFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = NewYorkDynamicColor.Background.sub
        view.layer.cornerRadius = Const.cornerRadius
        view.clipsToBounds = true
        return view
    }()

    private let textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = NewYorkDynamicColor.Background.separator
        return view
    }()

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    // MARK: - Initializers

    init(title: String?, message: String?) {
        super.init(frame: .zero)
        setupViews(title: title, message: message)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - NewYorkAlertViewType protocol method

    func addButtons(_ buttons: [NewYorkButton], cancelButton: NewYorkButton?) {
        var buttonArray: [NewYorkButton] = buttons
        if let cancel = cancelButton {
            if buttons.count == 1 {
                buttonArray.insert(cancel, at: 0)
            }
            else {
                buttonArray.append(cancel)
            }
        }

        if buttonArray.count == 2,
            let left = buttonArray.first,
            let right = buttonArray.last {
            addTwoButtons(left, right)
        }
        else {
            buttonStackView.axis = .vertical
            buttonArray.enumerated().forEach { index, button in
                if index != 0 {
                    buttonStackView.addSeparator()
                }
                buttonStackView.addArrangedSubview(button)
            }
        }
    }

    func addTextFields(_ textFields: [UITextField]) {
        contentStackView.addArrangedSubview(textFieldView)

        textFields.enumerated().forEach { index, tf in
            if index != 0 {
                textFieldStackView.addSeparator()
            }

            textFieldStackView.addArrangedSubview(tf)
        }
    }

    func addImage(_ image: UIImage?) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.insertArrangedSubview(imageView, at: 0)

        imageView.heightAnchor.constraint(equalToConstant: Const.imageHeight).isActive = true
    }

    func isBackgroundTap(point: CGPoint) -> Bool {
        !contentView.frame.contains(point)
    }

    // MARK: - Private method

    private func setupViews(title: String?, message: String?) {
        translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = title
        titleLabel.isHidden = title?.isEmpty ?? true
        messageLabel.text = message
        messageLabel.isHidden = message?.isEmpty ?? true

        textFieldView.addSubview(textFieldStackView)

        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(messageLabel)
        contentStackView.addArrangedSubview(labelStackView)

        contentView.addSubview(contentStackView)
        contentView.addSubview(separatorView)
        contentView.addSubview(buttonStackView)
        addSubview(contentView)

        var constraints: [NSLayoutConstraint] = []

        // Constraints for contentView
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: Const.ContentView.minMargin)
        let rightConstraint = rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Const.ContentView.minMargin)
        leftConstraint.priority = .defaultHigh
        rightConstraint.priority = .defaultHigh

        constraints += [
            leftConstraint,
            rightConstraint,
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.widthAnchor.constraint(lessThanOrEqualToConstant: Const.ContentView.maxWidth)
        ]

        // Constraints for contentStackView
        constraints += [
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Const.padding),
            contentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Const.padding),
            contentView.rightAnchor.constraint(equalTo: contentStackView.rightAnchor, constant: Const.padding)
        ]

        // Constraints for textFieldView
        constraints += [
            textFieldView.topAnchor.constraint(equalTo: textFieldStackView.topAnchor),
            textFieldView.leftAnchor.constraint(equalTo: textFieldStackView.leftAnchor),
            textFieldView.rightAnchor.constraint(equalTo: textFieldStackView.rightAnchor),
            textFieldView.bottomAnchor.constraint(equalTo: textFieldStackView.bottomAnchor)
        ]

        // Constraints for separatorView
        constraints += [
            separatorView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: Const.padding),
            separatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ]

        // Constraints for buttonStackView
        constraints += [
            buttonStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            buttonStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            buttonStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func addTwoButtons(_ left: NewYorkButton, _ right: NewYorkButton) {
        buttonStackView.axis = .horizontal
        buttonStackView.addArrangedSubview(left)
        buttonStackView.addSeparator()
        buttonStackView.addArrangedSubview(right)
        left.widthAnchor.constraint(equalTo: right.widthAnchor).isActive = true
    }
}
