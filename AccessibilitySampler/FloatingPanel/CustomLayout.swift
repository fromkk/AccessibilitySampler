//
//  CustomLayout.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/18.
//

import FloatingPanel
import UIKit

final class CustomLayout: FloatingPanelLayout {
    var position: FloatingPanelPosition = .bottom

    var initialState: FloatingPanelState = .half

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .half: FloatingPanelLayoutAnchor(
            absoluteInset: 200, edge: .bottom, referenceGuide: .safeArea),
        .full: FloatingPanelLayoutAnchor(
            absoluteInset: 64, edge: .top, referenceGuide: .safeArea),
    ]

    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        switch state {
        case .full:
            return 0.7
        case .half:
            return 0.3
        default:
            return 0.0
        }
    }
}
