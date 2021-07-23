//
//  TagValidator.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/23.
//

import Combine
import Foundation

enum TagValidatorResult: Equatable {
    case empty
    case unavailable
    case tooLong
    case available
}

enum TagValidator {
    static func check(with text: String) -> TagValidatorResult {
        guard !text.isEmpty else { return .empty }
        let usableCharacters = "abcdefghijklmnopqrstuvwxyz0123456789"
        guard
            text.filter({ char in
                !usableCharacters.contains(char.lowercased())
            }).isEmpty
        else {
            return .unavailable
        }

        let maxLength = 16
        guard text.count <= maxLength else {
            return .tooLong
        }

        return .available
    }
}
