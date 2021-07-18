//
//  DateAccessibleViewController.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/18.
//

import UIKit

final class DateAccessibleViewController: UIViewController {
    var now: NowRepresentable = Now()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Root.dateAccessible
        view.backgroundColor = UIColor.systemBackground
        addDateLabel()
        showNow()
    }

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.accessibilityIdentifier = #function
        return label
    }()

    private func addDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: dateLabel.trailingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
        ])
    }

    private func showNow() {
        dateLabel.text = L10n.currentDate(dateFormatter.string(from: now.now))
        dateLabel.accessibilityLabel = L10n.currentDate(
            accessibilityDateFormatter.string(from: now.now))
    }

    private lazy var dateFormatter: DateFormatter = {
        guard
            let dateFormat = DateFormatter.dateFormat(
                fromTemplate: "yyyy/MM/dd HH:mm", options: 0, locale: .current)
        else {
            fatalError("failed get date format from template")
        }
        var calendar = Calendar(identifier: .gregorian)
        let timeZone = TimeZone.current
        let locale = Locale.current
        calendar.locale = locale
        var dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }()

    private lazy var accessibilityDateFormatter: DateFormatter = {
        var calendar = Calendar(identifier: .gregorian)
        let timeZone = TimeZone.current
        let locale = Locale.current
        calendar.locale = locale
        var dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
}
