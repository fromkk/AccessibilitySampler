//
//  ViewController.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/17.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.title
        view.backgroundColor = UIColor.systemBackground
        addTableView()
        applyDataSource()
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

    private lazy var dataSource: UITableViewDiffableDataSource<RootSection, RootItem> = {
        let dataSource = UITableViewDiffableDataSource<RootSection, RootItem>(tableView: tableView)
        {
            tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = item.localizedTitle
            cell.accessibilityIdentifier = item.rawValue
            return cell
        }
        return dataSource
    }()

    private func applyDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<RootSection, RootItem>()
        snapshot.appendSections([.items])
        snapshot.appendItems(RootItem.allCases, toSection: .items)
        dataSource.apply(snapshot)
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }

        let item = RootItem.allCases[indexPath.row]
        item.show(on: self)
    }
}
