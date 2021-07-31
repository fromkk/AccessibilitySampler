//
//  ColorsViewController.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/31.
//

import UIKit

final class ColorsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Root.colors
        view.backgroundColor = UIColor.systemBackground
        addScrollView()
        addStackView()
        stackView.addArrangedSubview(pinkAndGreenButton)
        stackView.addArrangedSubview(redAndOrangeButton)
        stackView.addArrangedSubview(purpleAndBrownButton)
        stackView.addArrangedSubview(beigeAndPinkButton)
        stackView.addArrangedSubview(grayAndBlueButton)
    }

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.accessibilityIdentifier = #function
        scrollView.backgroundColor = UIColor.systemBackground
        return scrollView
    }()

    private func addScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: view.bounds)
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.accessibilityIdentifier = #function
        return stackView
    }()

    private func addStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            scrollView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
        ])
    }

    lazy var pinkAndGreenButton: UIButton = {
        let button = makeButton(
            with: "Pink and Geen",
            backgroundColor: #colorLiteral(
                red: 0.9341027737, green: 0.56566149, blue: 0.5387371778, alpha: 1),
            titleColor: #colorLiteral(
                red: 0.02205049433, green: 0.6860231757, blue: 0.4789237976, alpha: 1))
        button.accessibilityIdentifier = #function
        return button
    }()

    lazy var redAndOrangeButton: UIButton = {
        let button = makeButton(
            with: "Red and Ornage",
            backgroundColor: #colorLiteral(
                red: 0.9181475043, green: 0.382030189, blue: 0.117302753, alpha: 1),
            titleColor: #colorLiteral(
                red: 0.9602227807, green: 0.6334573627, blue: 0.00394566264, alpha: 1))
        button.accessibilityIdentifier = #function
        return button
    }()

    lazy var purpleAndBrownButton: UIButton = {
        let button = makeButton(
            with: "Purple and Brown",
            backgroundColor: #colorLiteral(
                red: 0.6818472147, green: 0.08487848192, blue: 0.5276781917, alpha: 1),
            titleColor: #colorLiteral(
                red: 0.5453833342, green: 0.2361306846, blue: 0.1663462222, alpha: 1))
        button.accessibilityIdentifier = #function
        return button
    }()

    lazy var beigeAndPinkButton: UIButton = {
        let button = makeButton(
            with: "Beige and Pink",
            backgroundColor: #colorLiteral(
                red: 0.9794847369, green: 0.8090292811, blue: 0.5710285306, alpha: 1),
            titleColor: #colorLiteral(
                red: 0.9341027737, green: 0.56566149, blue: 0.5387371778, alpha: 1))
        button.accessibilityIdentifier = #function
        return button
    }()

    lazy var grayAndBlueButton: UIButton = {
        let button = makeButton(
            with: "Gray and Blue",
            backgroundColor: #colorLiteral(
                red: 0.873257339, green: 0.8828656077, blue: 0.8780609965, alpha: 1),
            titleColor: #colorLiteral(
                red: 0.7259525061, green: 0.8895389438, blue: 0.9772928357, alpha: 1))
        button.accessibilityIdentifier = #function
        return button
    }()

    func makeButton(with text: String, backgroundColor: UIColor, titleColor: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = backgroundColor
        button.setTitle(text, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.contentEdgeInsets = .init(top: 8, left: 12, bottom: 8, right: 12)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.accessibilityTraits = [.button]
        return button
    }
}
