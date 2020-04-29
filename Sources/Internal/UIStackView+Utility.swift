//
//  Copyright © 2020 Satsuki Hashiba. All rights reserved.
//  GitHub: https://github.com/shiba1014
//

import UIKit

extension UIStackView {
    private enum Const {
        static let borderWidth: CGFloat = 1.0
    }

    func addSeparator() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = NewYorkDynamicColor.Background.separator
        addArrangedSubview(view)

        if axis == .horizontal {
            view.widthAnchor.constraint(equalToConstant: Const.borderWidth).isActive = true
        }
        else {
            view.heightAnchor.constraint(equalToConstant: Const.borderWidth).isActive = true
        }
    }
}
