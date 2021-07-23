//
//  TagViewModel.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/23.
//

import Combine
import Foundation

final class TagViewModel {
    private let _validateResult = CurrentValueSubject<TagValidatorResult, Never>(.empty)
    var validateResult: AnyPublisher<TagValidatorResult, Never> {
        _validateResult.eraseToAnyPublisher()
    }

    private let _tags = CurrentValueSubject<[Tag], Never>([])
    var tags: AnyPublisher<[Tag], Never> { _tags.eraseToAnyPublisher() }

    var canAdd: AnyPublisher<Bool, Never> {
        validateResult.map {
            if case .available = $0 {
                return true
            } else {
                return false
            }
        }.eraseToAnyPublisher()
    }

    var errorMessage: AnyPublisher<String?, Never> {
        validateResult.map {
            switch $0 {
            case .empty, .available:
                return nil
            case .unavailable:
                return L10n.Tag.Validation.unavailable
            case .tooLong:
                return L10n.Tag.Validation.tooLong
            }
        }
        .eraseToAnyPublisher()
    }

    func check(_ text: String) {
        _validateResult.send(TagValidator.check(with: text))
    }

    func add(_ text: String) {
        _tags.value.append(.init(rawValue: text))
    }

    func remove(at index: Int) {
        _tags.value.remove(at: index)
    }
}
