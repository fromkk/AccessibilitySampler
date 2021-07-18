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
        addHandImageView()
    }

    lazy var containerView: UIView = {
        let view = UIView(frame: view.bounds)
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor.secondarySystemBackground
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(tap(sender:))))
        view.accessibilityIdentifier = #function
        view.accessibilityLabel = L10n.tapHere
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
        showTappedAlert()
    }

    lazy var handImageView: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 280))
        let image = UIImage(systemName: "hand.raised", withConfiguration: configuration)
        let imageView = UIImageView(image: image)
        imageView.accessibilityIdentifier = #function
        return imageView
    }()

    private func addHandImageView() {
        handImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(handImageView)
        NSLayoutConstraint.activate([
            handImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: handImageView.trailingAnchor),
            handImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: handImageView.bottomAnchor),
        ])
    }
}
