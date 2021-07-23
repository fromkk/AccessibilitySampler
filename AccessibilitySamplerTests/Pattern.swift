//
//  Pattern.swift
//  AccessibilitySamplerTests
//
//  Created by Kazuya Ueoka on 2021/07/23.
//

import Foundation

struct Pattern<X: Equatable, Y: Equatable> {
    let input: X
    let assertion: Y
    let file: StaticString
    let line: UInt
    init(input: X, assertion: Y, file: StaticString = #file, line: UInt = #line) {
        self.input = input
        self.assertion = assertion
        self.file = file
        self.line = line
    }
}
