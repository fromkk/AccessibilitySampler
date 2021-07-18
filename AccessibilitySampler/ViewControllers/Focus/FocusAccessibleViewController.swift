//
//  FocusAccessibleViewController.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/18.
//

import UIKit

final class FocusAccessibleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Root.focusAccessible
        view.backgroundColor = UIColor.systemBackground
        addNextButton()
        addMessageLabel()
    }

    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(L10n.next, for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
        button.addTarget(self, action: #selector(next(sender:)), for: .touchUpInside)
        button.accessibilityIdentifier = #function
        return button
    }()

    private func addNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            nextButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: nextButton.trailingAnchor, constant: 16),
        ])
    }

    @objc private func next(sender: Any) {
        UIAccessibility.post(notification: .layoutChanged, argument: messageLabel)
    }

    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = L10n.focusHere
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func addMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: messageLabel.trailingAnchor, constant: 16),
            messageLabel.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 32),
        ])
    }
}
