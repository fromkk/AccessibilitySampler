//
//  SwitchAccessibleViewController.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/22.
//

import UIKit

final class SwitchAccessibleViewController: UIViewController {
    enum Section {
        case items
    }

    enum Item: String, Hashable, CaseIterable {
        case a
        case b
        case c
        case d
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Root.switchAccessible
        view.backgroundColor = UIColor.systemBackground
        addTableView()
        applyDataSource()
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 4
        tableView.register(
            SwitchAccessibleViewCell.self,
            forCellReuseIdentifier: SwitchAccessibleViewCell.reusableIdentifier)
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
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: SwitchAccessibleViewCell.reusableIdentifier, for: indexPath)
                as! SwitchAccessibleViewCell
            cell.titleLabel.text = item.rawValue
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
}
