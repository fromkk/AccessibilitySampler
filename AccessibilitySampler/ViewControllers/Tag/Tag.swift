//
//  Tag.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/23.
//

import Foundation

struct Tag: Hashable {
    let rawValue: String
    init(rawValue: String) {
        self.rawValue = rawValue
    }
}
