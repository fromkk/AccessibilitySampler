//
//  RootItem.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/22.
//

import FloatingPanel
import UIKit

enum RootSection: CaseIterable, Hashable {
    case items
}

enum RootItem: CaseIterable, Hashable {
    case tapNotAccessible
    case tapAccessible
    case buttonNotAccessible
    case buttonAccessible
    case modalNotAccessible
    case modalAccessible
    case focusNotAccessible
    case focusAccessible
    case dateNotAccessible
    case dateAccessible
    case switchNotAccessible
    case switchAccessible
    case headlineNotAccessible
    case headlineAccessible

    var localizedTitle: String {
        switch self {
        case .buttonNotAccessible:
            return L10n.Root.buttonNotAccessible
        case .buttonAccessible:
            return L10n.Root.buttonAccessible
        case .tapNotAccessible:
            return L10n.Root.tapNotAccessible
        case .tapAccessible:
            return L10n.Root.tapAccessible
        case .modalNotAccessible:
            return L10n.Root.modalNotAccessible
        case .modalAccessible:
            return L10n.Root.modalAccessible
        case .focusNotAccessible:
            return L10n.Root.focusNotAccessible
        case .focusAccessible:
            return L10n.Root.focusAccessible
        case .dateNotAccessible:
            return L10n.Root.dateNotAccessible
        case .dateAccessible:
            return L10n.Root.dateAccessible
        case .switchNotAccessible:
            return L10n.Root.switchNotAccessible
        case .switchAccessible:
            return L10n.Root.switchAccessible
        case .headlineNotAccessible:
            return L10n.Root.headlineNotAccessible
        case .headlineAccessible:
            return L10n.Root.headlineAccessible
        }
    }

    func show(on viewController: UIViewController) {
        switch self {
        case .buttonNotAccessible:
            showButtonNotAccessibleView(on: viewController)
        case .buttonAccessible:
            showButtonAccessibleView(on: viewController)
        case .tapNotAccessible:
            showTapNotAccessibleView(on: viewController)
        case .tapAccessible:
            showTapAccessibleView(on: viewController)
        case .modalNotAccessible:
            showModalNotAccessible(on: viewController)
        case .modalAccessible:
            showModalAccessible(on: viewController)
        case .focusNotAccessible:
            showFocusNotAccessibleView(on: viewController)
        case .focusAccessible:
            showFocusAccessibleView(on: viewController)
        case .dateNotAccessible:
            showDateNotAccessibleView(on: viewController)
        case .dateAccessible:
            showDateAccessibleView(on: viewController)
        case .switchNotAccessible:
            showSwitchNotAccessibleView(on: viewController)
        case .switchAccessible:
            showSwitchAccessibleView(on: viewController)
        case .headlineNotAccessible:
            showHeadlineNotAccessibleView(on: viewController)
        case .headlineAccessible:
            showHeadlineAccessibleView(on: viewController)
        }
    }

    private func showButtonNotAccessibleView(on viewController: UIViewController) {
        let vc = ButtonNotAccessibleViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    private func showButtonAccessibleView(on viewController: UIViewController) {
        let vc = ButtonAccessibleViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    private func showTapNotAccessibleView(on viewController: UIViewController) {
        let vc = TapNotAccessibleViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    private func showTapAccessibleView(on viewController: UIViewController) {
        let vc = TapAccessibleViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    private func showModalNotAccessible(on viewController: UIViewController) {
        let vc = ModalNotAccessibleViewController()
        let fpc = FloatingPanelController()
        fpc.set(contentViewController: vc)
        fpc.isRemovalInteractionEnabled = true
        fpc.layout = CustomLayout()
        viewController.present(fpc, animated: true)
    }

    private func showModalAccessible(on viewController: UIViewController) {
        let vc = ModalAccessibleViewController()
        let fpc = FloatingPanelController()
        fpc.set(contentViewController: vc)
        fpc.isRemovalInteractionEnabled = true
        fpc.layout = CustomLayout()
        viewController.present(fpc, animated: true)
    }

    private func showFocusNotAccessibleView(on viewController: UIViewController) {
        let vc = FocusNotAccessibleViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    private func showFocusAccessibleView(on viewController: UIViewController) {
        let vc = FocusAccessibleViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    private func showDateNotAccessibleView(on viewController: UIViewController) {
        let vc = DateNotAccessibleViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    private func showDateAccessibleView(on viewController: UIViewController) {
        let vc = DateAccessibleViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    private func showSwitchNotAccessibleView(on viewController: UIViewController) {
        let vc = SwitchNotAccessibleViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    private func showSwitchAccessibleView(on viewController: UIViewController) {
        let vc = SwitchAccessibleViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    private func showHeadlineNotAccessibleView(on viewController: UIViewController) {
        let vc = HeadlineNotAccessibleViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    private func showHeadlineAccessibleView(on viewController: UIViewController) {
        let vc = HeadlineAccessibleViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
