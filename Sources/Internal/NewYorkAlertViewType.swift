//
//  Copyright © 2020 Satsuki Hashiba. All rights reserved.
//  GitHub: https://github.com/shiba1014
//

import UIKit

protocol NewYorkAlertViewType: UIView {
    func addButtons(_ buttons: [NewYorkButton], cancelButton: NewYorkButton?)
    func addTextFields(_  textFields: [UITextField])
    func addImage(_ image: UIImage?)
    func isBackgroundTap(point: CGPoint) -> Bool
}
