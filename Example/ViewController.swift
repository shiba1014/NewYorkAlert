//
//  Copyright © 2020 Satsuki Hashiba. All rights reserved.
//  GitHub: https://github.com/shiba1014
//

import UIKit
import NewYorkAlert

class ViewController: UIViewController {

    enum Section: Int, CaseIterable {
        case alert
        case actionSheet

        func getTitle() -> String {
            switch self {
            case .alert: return "Alert"
            case .actionSheet: return "Action sheet"
            }
        }
    }

    struct Row {
        var title: String
        var selected: () -> Void
    }

    @IBOutlet weak var tableView: UITableView!

    var alertRows: [Row] = []
    var actionSheetRows: [Row] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "NewYorkAlert"

        alertRows = [
            Row(title: "Standard", selected: { [weak self] in
                self?.showStandardAlert()
            }),
            Row(title: "All button styles", selected: { [weak self] in
                self?.showAllStyleButtonsAlert()
            }),
            Row(title: "Image", selected: {  [weak self] in
                self?.showImageAlert()
            }),
            Row(title: "Text fields", selected: { [weak self] in
                self?.showTextFieldsAlert()
            })
        ]

        actionSheetRows = [
            Row(title: "Standard", selected: { [weak self] in
                self?.showStandardActionSheet()
            }),
            Row(title: "Image", selected: { [weak self] in
                self?.showImageActionSheet()
            }),
            Row(title: "All colors", selected: { [weak self] in
                self?.showAllColorsActionSheet()
            })
        ]

        tableView.dataSource = self
        tableView.delegate = self
    }

    func showStandardAlert() {
        let alert = NewYorkAlertController(title: "Standard", message: "This is a standard alert.", style: .alert)

        let ok = NewYorkButton(title: "OK", style: .default) { _ in
            print("Tapped OK")
        }
        let cancel = NewYorkButton(title: "Cancel", style: .cancel)

        alert.addButton(ok)
        alert.addButton(cancel)

        present(alert, animated: true)
    }

    func showAllStyleButtonsAlert() {
        let alert = NewYorkAlertController(title: "All button styles", message: "These are buttons in all styles of NewYorkAlert.", style: .alert)

        let defaultButton = NewYorkButton(title: "Default", style: .default) { _ in
            print("Tapped default button")
        }
        defaultButton.setDynamicColor(.indigo)

        let preferred = NewYorkButton(title: "Preferred", style: .preferred) { _ in
            print("Tapped preferred button")
        }
        preferred.setDynamicColor(.indigo)

        let destructive = NewYorkButton(title: "Destructive", style: .destructive) { _ in
            print("Tapped destructive button")
        }

        let cancel = NewYorkButton(title: "Cancel", style: .cancel) { _ in
            print("Tapped cancel button")
        }

        alert.addButtons([defaultButton, preferred, destructive, cancel])

        present(alert, animated: true)
    }

    func showImageAlert() {
        let alert = NewYorkAlertController(title: "Image", message: "This is an alert with an image. You can set only one image to NewYorkAlert.", style: .alert)

        alert.addImage(UIImage(named: "Image"))

        let ok = NewYorkButton(title: "OK", style: .default) { _ in
            print("Tapped OK")
        }
        ok.setDynamicColor(.purple)
        let cancel = NewYorkButton(title: "Cancel", style: .cancel)
        alert.addButtons([ok, cancel])

        present(alert, animated: true)
    }

    func showTextFieldsAlert() {
        let alert = NewYorkAlertController.init(title: "Text fields", message: "This is an alert with text fields. \nThis alert can't be dismissed via tap gesture.", style: .alert)

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

        alert.isTapDismissalEnabled = false

        present(alert, animated: true)
    }

    func showStandardActionSheet() {
        let actionSheet = NewYorkAlertController(title: "Standard", message: "This is a standard action sheet.", style: .actionSheet)

        let titles = ["Apple", "Ogrange", "Lemon"]
        actionSheet.addButtons(
            titles.enumerated().map { index, title -> NewYorkButton in
                let button = NewYorkButton(title: title, style: .default) { button in
                    print("Selected \(titles[button.tag])")
                }
                button.tag = index
                button.setDynamicColor(.orange)
                return button
            }
        )

        let cancel = NewYorkButton(title: "Cancel", style: .cancel)
        actionSheet.addButton(cancel)

        present(actionSheet, animated: true)
    }

    func showImageActionSheet() {
        let actionSheet = NewYorkAlertController(title: "Image", message: "This is a action sheet with an image. You can set only one image to NewYorkAlert.", style: .actionSheet)

        actionSheet.addImage(UIImage(named: "Image"))

        let buttons = (1...3).map { i -> NewYorkButton in
            let button = NewYorkButton(title: "Option \(i)", style: .default) { _ in
                print("Tapped option \(i)")
            }
            button.setDynamicColor(.pink)
            return button
        }
        actionSheet.addButtons(buttons)

        let cancel = NewYorkButton(title: "Cancel", style: .cancel)
        actionSheet.addButton(cancel)

        present(actionSheet, animated: true)
    }

    func showAllColorsActionSheet() {
        let actionSheet = NewYorkAlertController(title: "All colors", message: "These are all colors of NewYorkAlert.", style: .actionSheet)

        let red = NewYorkButton(title: "Red", style: .default)
        red.setDynamicColor(.red)

        let orange = NewYorkButton(title: "Orange", style: .default)
        orange.setDynamicColor(.orange)

        let yellow = NewYorkButton(title: "Yellow", style: .default)
        yellow.setDynamicColor(.yellow)

        let green = NewYorkButton(title: "Green", style: .default)
        green.setDynamicColor(.green)

        let teal = NewYorkButton(title: "Teal", style: .default)
        teal.setDynamicColor(.teal)

        let blue = NewYorkButton(title: "Blue", style: .default)
        blue.setDynamicColor(.blue)

        let indigo = NewYorkButton(title: "Indigo", style: .default)
        indigo.setDynamicColor(.indigo)

        let purple = NewYorkButton(title: "Purple", style: .default)
        purple.setDynamicColor(.purple)

        let pink = NewYorkButton(title: "Pink", style: .default)
        pink.setDynamicColor(.pink)

        let cancel = NewYorkButton(title: "Cancel", style: .cancel)

        actionSheet.addButtons([red, orange, yellow, green, teal, blue, indigo, purple, pink, cancel])

        present(actionSheet, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Section(rawValue: section)?.getTitle()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .alert: return alertRows.count
        case .actionSheet: return actionSheetRows.count
        case .none: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell"),
            let section = Section(rawValue: indexPath.section) else { return .init() }

        switch section {
        case .alert: cell.textLabel?.text = alertRows[indexPath.row].title
        case .actionSheet: cell.textLabel?.text = actionSheetRows[indexPath.row].title
        }

        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }

        switch section {
        case .alert: alertRows[indexPath.row].selected()
        case .actionSheet: actionSheetRows[indexPath.row].selected()
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
