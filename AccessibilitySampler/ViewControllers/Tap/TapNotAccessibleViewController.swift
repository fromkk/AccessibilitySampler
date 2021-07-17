//
//  TapNotAccessibleViewController.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/17.
//

import UIKit

final class TapNotAccessibleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        addContainerView()
        addTapHereLabel()
    }

    lazy var containerView: UIView = {
        let view = UIView(frame: view.bounds)
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor.secondarySystemBackground
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(tap(sender:))))
        view.accessibilityElements = [tapHereLabel]
        view.accessibilityIdentifier = #function
        return view
    }()

    private func addContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -64),
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc private func tap(sender: UITapGestureRecognizer) {
        print("\(#function)")
    }

    lazy var tapHereLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap here!"
        label.textColor = UIColor.link
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.isUserInteractionEnabled = false
        label.isAccessibilityElement = false
        label.accessibilityIdentifier = #function
        return label
    }()

    private func addTapHereLabel() {
        tapHereLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(tapHereLabel)
        NSLayoutConstraint.activate([
            tapHereLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(
                equalTo: tapHereLabel.trailingAnchor, constant: 16),
            tapHereLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
}
