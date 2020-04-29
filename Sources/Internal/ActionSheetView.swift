//
//  Copyright © 2020 Satsuki Hashiba. All rights reserved.
//  GitHub: https://github.com/shiba1014
//

import UIKit

final class ActionSheetView: UIView, NewYorkAlertViewType {

    // MARK: Constants

    private enum Const {
        enum FontSize {
            static let title: CGFloat = 16
            static let message: CGFloat = 14
        }

        enum Spacing {
            static let large: CGFloat = 16
            static let small: CGFloat = 8
        }

        static let margin: CGFloat = 8
        static let padding: CGFloat = 16
        static let maxActionSheetWidth: CGFloat = 400
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

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()

    private let cancelButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = NewYorkDynamicColor.Background.default
        view.layer.cornerRadius = Const.cornerRadius
        view.clipsToBounds = true
        return view
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
        if let cancelButton = cancelButton {
            addCancelButton(cancelButton)
        }

        buttons.forEach {
            buttonStackView.addSeparator()
            buttonStackView.addArrangedSubview($0)
        }
    }

    func addTextFields(_ textField: [UITextField]) {
        fatalError("Text fields cannot be added to NewYorkAlertController of style NewYorkAlertController.Style.actionSheet")
    }

    func addImage(_ image: UIImage?) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.insertArrangedSubview(imageView, at: 0)

        imageView.heightAnchor.constraint(equalToConstant: Const.imageHeight).isActive = true
    }

    func isBackgroundTap(point: CGPoint) -> Bool {
        !contentView.frame.union(cancelButtonView.frame).contains(point)
    }

    // MARK: - Private method

    private func setupViews(title: String?, message: String?) {
        translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = title
        titleLabel.isHidden = title?.isEmpty ?? true
        messageLabel.text = message
        messageLabel.isHidden = message?.isEmpty ?? true

        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(messageLabel)
        contentStackView.addArrangedSubview(labelStackView)

        contentView.addSubview(contentStackView)
        contentView.addSubview(buttonStackView)
        addSubview(contentView)
        addSubview(cancelButtonView)

        var constraints: [NSLayoutConstraint] = []

        // Constraints for contentView
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: Const.margin)
        let rightConstraint = rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Const.margin)
        leftConstraint.priority = .defaultHigh
        rightConstraint.priority = .defaultHigh

        constraints += [
            leftConstraint,
            rightConstraint,
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.widthAnchor.constraint(lessThanOrEqualToConstant: Const.maxActionSheetWidth)
        ]

        // Constraints for contentStackView
        constraints += [
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Const.padding),
            contentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Const.padding),
            contentView.rightAnchor.constraint(equalTo: contentStackView.rightAnchor, constant: Const.padding)
        ]

        // Constraints for buttonStackView
        constraints += [
            buttonStackView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: Const.padding),
            buttonStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            buttonStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]

        // Constraints for cancelButtonView
        constraints += [
            cancelButtonView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Const.margin),
            cancelButtonView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            cancelButtonView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            bottomAnchor.constraint(equalTo: cancelButtonView.bottomAnchor, constant: Const.margin)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func addCancelButton(_ button: NewYorkButton) {
        cancelButtonView.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: cancelButtonView.topAnchor),
            button.leftAnchor.constraint(equalTo: cancelButtonView.leftAnchor),
            cancelButtonView.rightAnchor.constraint(equalTo: button.rightAnchor),
            cancelButtonView.bottomAnchor.constraint(equalTo: button.bottomAnchor)
        ])
    }
}
