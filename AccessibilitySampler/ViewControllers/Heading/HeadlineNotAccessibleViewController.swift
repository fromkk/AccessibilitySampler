//
//  HeadlineNotAccessibleViewController.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/22.
//

import UIKit

final class HeadlineNotAccessibleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Root.headlineNotAccessible
        view.backgroundColor = UIColor.systemBackground
        addScrollView()
        addStackView()
        showTexts()
    }

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.accessibilityIdentifier = #function
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
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 16),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            scrollView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
        ])
    }

    private func makeHeadlineLabel(with title: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor.label
        label.text = title
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }

    private func makeTextLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.label
        label.text = text
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }

    private func showTexts() {
        sections.forEach {
            stackView.addArrangedSubview(makeHeadlineLabel(with: $0.title))
            $0.texts.forEach {
                stackView.addArrangedSubview(makeTextLabel(with: $0))
            }
        }
    }

    struct Section {
        let title: String
        let texts: [String]
    }
    let sections: [Section] = [
        Section(
            title: "???????????????T??????????????????????????????????????????????????????",
            texts: [
                "2??????????????????AltConf???????????????????????????Cupertino???Apple Store?????????????????????????????????T??????????????????????????????????????????????????????????????????????????????????????????????????????",
                "?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????",
            ]),
        Section(
            title: "??????????????????",
            texts: [
                "Amazon????????????????????????????????????????????????????????????????????????"
            ]),
        Section(
            title: "???????????????",
            texts: [
                "????????????????????????YouTube?????????????????????????????????????????????????????????????????????????????????????????????",
                "?????????????????????????????????",
                "????????????????????????",
                "????????????????????????T?????????????????????????????????",
                "??????????????????????????????????????????",
                "?????????????????????????????????",
                "??????????????????????????????????????????",
                "????????????????????????",
                "???????????????",
            ]),
        Section(
            title: "?????????",
            texts: [
                "????????????????????????????????????????????????????????????T?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????",
                "???????????????T???????????????????????????????????????????????????????????????????????????????????????",
            ]),
    ]
}
