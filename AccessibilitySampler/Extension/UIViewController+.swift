//
//  UIViewController+.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/18.
//

import UIKit

extension UIViewController {
    func showTappedAlert() {
        let alertController = UIAlertController(
            title: "", message: L10n.tapped, preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(title: L10n.ok, style: .default, handler: nil)
        )
        present(alertController, animated: true)
    }
}
