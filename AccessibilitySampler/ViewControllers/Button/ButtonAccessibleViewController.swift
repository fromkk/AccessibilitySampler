//
//  ButtonAccessibleViewController.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/17.
//

import UIKit

final class ButtonAccessibleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Root.buttonAccessible
        view.backgroundColor = UIColor.systemBackground
        addButton()
    }

    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        let configuration = UIImage.SymbolConfiguration(
            font: UIFont.systemFont(ofSize: 280))
        let image = UIImage(systemName: "heart", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.systemRed
        button.addTarget(self, action: #selector(tap(sender:)), for: .touchUpInside)
        button.accessibilityLabel = L10n.like
        button.accessibilityIdentifier = #function
        return button
    }()

    private func addButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            button.heightAnchor.constraint(equalTo: button.widthAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc private func tap(sender: Any) {
        showTappedAlert()
    }
}
