//
//  TagNotAccessibleViewController.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/23.
//

import Combine
import UIKit

final class TagNotAccessibleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Root.tagNotAccessible
        view.backgroundColor = UIColor.systemBackground
        addToolbar()
        addAddButton()
        addTextField()
        addTableView()
        subscribeKeyboards()
    }

    // MARK: - UI

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(tapTableView(sender:))))
        tableView.accessibilityIdentifier = #function
        return tableView
    }()

    private func addTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            toolbar.topAnchor.constraint(equalTo: tableView.bottomAnchor),
        ])
    }

    @objc private func tapTableView(sender: UITapGestureRecognizer) {
        guard textField.isFirstResponder else { return }
        textField.resignFirstResponder()
    }

    lazy var toolbar: UIView = {
        let toolbar = UIView(
            frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.size.width, height: 50)))
        let separator = UIView(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: view.bounds.size.width, height: 1 / UIScreen.main.scale)))
        separator.backgroundColor = UIColor.systemGray3
        separator.translatesAutoresizingMaskIntoConstraints = false
        toolbar.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: toolbar.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: separator.trailingAnchor),
            separator.topAnchor.constraint(equalTo: toolbar.topAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale),
        ])
        toolbar.backgroundColor = UIColor.systemBackground
        return toolbar
    }()

    private lazy var toolbarBottomConstraint: NSLayoutConstraint = view.safeAreaLayoutGuide
        .bottomAnchor.constraint(equalTo: toolbar.bottomAnchor)
    private func addToolbar() {
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolbar)
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: toolbar.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 50),
            toolbarBottomConstraint,
        ])
    }

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.label
        textField.placeholder = L10n.Tag.placeholder
        textField.accessibilityIdentifier = #function
        return textField
    }()

    private func addTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        toolbar.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: toolbar.leadingAnchor, constant: 8),
            addButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8),
            textField.heightAnchor.constraint(equalToConstant: 32),
            textField.centerYAnchor.constraint(equalTo: toolbar.centerYAnchor),
        ])
    }

    lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(L10n.Tag.add, for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
        button.accessibilityIdentifier = #function
        return button
    }()

    private func addAddButton() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        toolbar.addSubview(addButton)
        NSLayoutConstraint.activate([
            toolbar.trailingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 8),
            addButton.centerYAnchor.constraint(equalTo: toolbar.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 44),
        ])
    }

    // MARK: - Combine

    private var cancellables: Set<AnyCancellable> = .init()
    private func subscribeKeyboards() {
        NotificationCenter.default.publisher(
            for: UIResponder.keyboardWillShowNotification, object: nil
        )
        .compactMap { $0.keyboard }
        .sink { [weak self] keyboard in
            guard let self = self else { return }
            self.toolbarBottomConstraint.constant =
                keyboard.frame.size.height - self.view.safeAreaInsets.bottom
            UIView.animate(
                withDuration: keyboard.animationDuration, delay: 0,
                options: [keyboard.animationCurve]
            ) { [weak self] in
                self?.view.setNeedsLayout()
                self?.view.layoutIfNeeded()
            }
        }
        .store(in: &cancellables)

        NotificationCenter.default.publisher(
            for: UIResponder.keyboardWillHideNotification, object: nil
        )
        .compactMap { $0.keyboard }
        .sink { [weak self] keyboard in
            guard let self = self else { return }
            self.toolbarBottomConstraint.constant = 0
            UIView.animate(
                withDuration: keyboard.animationDuration, delay: 0,
                options: [keyboard.animationCurve]
            ) { [weak self] in
                self?.view.setNeedsLayout()
                self?.view.layoutIfNeeded()
            }
        }
        .store(in: &cancellables)
    }
}
