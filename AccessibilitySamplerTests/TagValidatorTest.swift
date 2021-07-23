//
//  TagValidatorTest.swift
//  AccessibilitySamplerTests
//
//  Created by Kazuya Ueoka on 2021/07/23.
//

@testable import AccessibilitySampler
import XCTest

final class TagValidatorTest: XCTestCase {
    func testValidation() {
        let patterns: [Pattern<String, TagValidatorResult>] = [
            .init(input: "", assertion: .empty),
            .init(input: "!!!", assertion: .unavailable),
            .init(input: "abcdefgHIJKLMN123", assertion: .tooLong),
            .init(input: "1234567890aBcDeF", assertion: .available)
        ]
        patterns.forEach {
            XCTAssertEqual(TagValidator.check(with: $0.input), $0.assertion, file: $0.file, line: $0.line)
        }
    }
}
