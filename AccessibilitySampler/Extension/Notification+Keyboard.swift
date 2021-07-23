//
//  Notification+Keyboard.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/23.
//

import UIKit

extension Notification {
    struct Keyboard {
        let frame: CGRect
        let animationDuration: TimeInterval
        let animationCurve: UIView.AnimationOptions
    }

    var keyboard: Keyboard? {
        guard let frame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
                as? TimeInterval,
            let animationCurve = userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else {
            return nil
        }
        return Keyboard(
            frame: frame, animationDuration: animationDuration,
            animationCurve: UIView.AnimationOptions(rawValue: animationCurve))
    }
}
