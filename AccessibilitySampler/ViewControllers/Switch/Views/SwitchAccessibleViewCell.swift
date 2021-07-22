//
//  SwitchAccessibleViewCell.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/22.
//

import UIKit

final class SwitchAccessibleViewCell: UITableViewCell {
    static let reusableIdentifier: String = String(describing: type(of: self))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    private lazy var setUp: () -> Void = {
        isAccessibilityElement = true
        backgroundColor = UIColor.systemBackground
        selectionStyle = .none
        addToggleSwitch()
        addTitleLabel()
        return {}
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.accessibilityIdentifier = #function
        return label
    }()

    private func addTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            toggleSwitch.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
        ])
    }

    lazy var toggleSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.accessibilityIdentifier = #function
        return switchView
    }()

    private func addToggleSwitch() {
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(toggleSwitch)
        NSLayoutConstraint.activate([
            contentView.trailingAnchor.constraint(
                equalTo: toggleSwitch.trailingAnchor, constant: 16),
            toggleSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    // MARK: - Accessible

    override var accessibilityLabel: String? {
        get {
            titleLabel.text
        }
        set {}
    }

    override var accessibilityValue: String? {
        get {
            toggleSwitch.accessibilityValue
        }
        set {}
    }

    override var accessibilityTraits: UIAccessibilityTraits {
        get {
            toggleSwitch.accessibilityTraits
        }
        set {}
    }

    override func accessibilityActivate() -> Bool {
        toggleSwitch.isOn.toggle()
        return true
    }
}
