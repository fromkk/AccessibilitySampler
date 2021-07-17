//
//  ViewController.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/17.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    enum Section: CaseIterable, Hashable {
        case items
    }

    enum Item: CaseIterable, Hashable {
        case buttonNotAccessible
        case buttonAccessible
        case tapNotAccessible
        var localizedTitle: String {
            switch self {
            case .buttonNotAccessible:
                return L10n.Root.buttonNotAccessible
            case .buttonAccessible:
                return L10n.Root.buttonAccessible
            case .tapNotAccessible:
                return L10n.Root.tapNotAccessible
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.title
        view.backgroundColor = UIColor.systemBackground
        addTableView()
        applyDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

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
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
        ])
    }

    private lazy var dataSource: UITableViewDiffableDataSource<Section, Item> = {
        let dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView) {
            tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = item.localizedTitle
            return cell
        }
        return dataSource
    }()

    private func applyDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.items])
        snapshot.appendItems(Item.allCases, toSection: .items)
        dataSource.apply(snapshot)
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = Item.allCases[indexPath.row]
        switch item {
        case .buttonNotAccessible:
            showButtonNotAccessibleView()
        case .buttonAccessible:
            showButtonAccessibleView()
        case .tapNotAccessible:
            showTapNotAccessibleView()
        }
    }

    private func showButtonNotAccessibleView() {
        let viewController = ButtonNotAccessibleViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func showButtonAccessibleView() {
        let viewController = ButtonAccessibleViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func showTapNotAccessibleView() {
        let viewController = TapNotAccessibleViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
