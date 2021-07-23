//
//  TagViewModel.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/23.
//

import Combine
import Foundation

final class TagViewModel {
    private var cancellables: Set<AnyCancellable> = .init()
    init() {
        subscribeAdd()
    }

    private func subscribeAdd() {
        _add
            .sink { [weak self] in
                let result = TagValidator.check(with: $0)
                guard case .available = result else { return }
                self?._tags.value.append(.init(rawValue: $0))
            }
            .store(in: &cancellables)
    }

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

    private let _add = PassthroughSubject<String, Never>()

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
        _add.send(text)
    }

    func remove(at index: Int) {
        _tags.value.remove(at: index)
    }
}
