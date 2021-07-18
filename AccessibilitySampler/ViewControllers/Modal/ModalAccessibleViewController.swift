//
//  ModalAccessibleViewController.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/18.
//

import Combine
import UIKit

final class ModalAccessibleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        addCloseButton()
        addTextLabel()
        handleVoiceOverStatus()
        subscribeVoiceOver()
    }

    // MARK: - Subscribe

    private var cancellable: AnyCancellable?
    private func subscribeVoiceOver() {
        cancellable?.cancel()
        cancellable = NotificationCenter.default.publisher(
            for: UIAccessibility.voiceOverStatusDidChangeNotification
        )
        .sink { [weak self] _ in
            self?.handleVoiceOverStatus()
        }
    }

    private func handleVoiceOverStatus() {
        closeButton.isHidden = !UIAccessibility.isVoiceOverRunning
    }

    // MARK: - UI

    lazy var closeButton: UIButton = {
        let configuration = UIImage.SymbolConfiguration(
            font: UIFont.preferredFont(forTextStyle: .headline))
        let image = UIImage(systemName: "xmark", withConfiguration: configuration)

        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.accessibilityLabel = L10n.close
        button.tintColor = UIColor.label
        button.addTarget(self, action: #selector(close(sender:)), for: .touchUpInside)
        button.accessibilityIdentifier = #function
        return button
    }()

    private func addCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: closeButton.trailingAnchor, constant: 16),
            closeButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
        ])
    }

    @objc private func close(sender: Any) {
        dismiss(animated: true)
    }

    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = L10n.modal
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.accessibilityIdentifier = #function
        return label
    }()

    private func addTextLabel() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 16),
            textLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
        ])
    }
}
