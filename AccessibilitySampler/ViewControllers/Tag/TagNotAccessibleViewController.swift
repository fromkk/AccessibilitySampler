//
//  TagNotAccessibleViewController.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/23.
//

import Combine
import UIKit

final class TagNotAccessibleViewController: UIViewController, UITableViewDelegate {
    enum Section {
        case tags
    }

    var viewModel: TagViewModel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Root.tagNotAccessible
        view.backgroundColor = UIColor.systemBackground
        addToolbar()
        addAddButton()
        addTextField()
        addErrorLabel()
        addTableView()
        subscribe()
    }

    // MARK: - UI

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
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

    private lazy var dataSource: UITableViewDiffableDataSource<Section, Tag> = {
        let dataSource = UITableViewDiffableDataSource<Section, Tag>(tableView: tableView) {
            tableView, indexPath, tag in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.text = tag.rawValue
            return cell
        }
        return dataSource
    }()

    private let lock = NSLock()
    private func applyDataSource(with tags: [Tag]) {
        lock.lock()
        defer {
            lock.unlock()
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Tag>()
        snapshot.appendSections([.tags])
        snapshot.appendItems(tags, toSection: .tags)
        dataSource.apply(snapshot)
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
            textField.topAnchor.constraint(equalTo: toolbar.topAnchor, constant: 16),
            toolbar.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
        ])
    }

    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemRed
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.accessibilityIdentifier = #function
        return label
    }()

    private func addErrorLabel() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        toolbar.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: toolbar.leadingAnchor, constant: 8),
            toolbar.trailingAnchor.constraint(equalTo: errorLabel.trailingAnchor, constant: 8),
            textField.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 2),
        ])
    }

    lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(L10n.Tag.add, for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
        button.setTitleColor(UIColor.systemGray3, for: .disabled)
        button.addTarget(self, action: #selector(add(sender:)), for: .touchUpInside)
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

    @objc private func add(sender: Any) {
        textField.resignFirstResponder()
        if let text = textField.text, !text.isEmpty {
            viewModel.add(text)
        }
        textField.text = nil
        viewModel.check("")
    }

    // MARK: - Combine

    private var cancellables: Set<AnyCancellable> = .init()
    private func subscribe() {
        subscribeKeyboards()
        subscribeTags()
        subscribeTextField()
    }

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

    private func subscribeTags() {
        viewModel.tags
            .removeDuplicates()
            .sink { [weak self] in
                self?.applyDataSource(with: $0)
            }
            .store(in: &cancellables)
    }

    private func subscribeTextField() {
        let textPublisher = Publishers.Merge(
            NotificationCenter.default.publisher(
                for: UITextField.textDidBeginEditingNotification, object: textField),
            NotificationCenter.default.publisher(
                for: UITextField.textDidChangeNotification, object: textField)
        )
        .compactMap { $0.object as? UITextField }
        .map { $0.text }

        textPublisher
            .removeDuplicates()
            .sink { [weak self] in
                self?.viewModel.check($0 ?? "")
            }
            .store(in: &cancellables)

        viewModel.canAdd.assign(to: \.isEnabled, on: addButton).store(in: &cancellables)
        viewModel.errorMessage.assign(to: \.text, on: errorLabel).store(in: &cancellables)
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.remove(at: indexPath.row)
    }
}
