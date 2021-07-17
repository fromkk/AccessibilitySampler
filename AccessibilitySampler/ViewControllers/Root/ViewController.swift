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
        case button
        var localizedTitle: String {
            switch self {
            case .button:
                return L10n.Root.button
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
        case .button:
            showButtonView()
        }
    }

    private func showButtonView() {
        let viewController = ButtonViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}