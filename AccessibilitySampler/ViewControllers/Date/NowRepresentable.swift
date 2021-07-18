//
//  NowRepresentable.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/18.
//

import Foundation

protocol NowRepresentable {
    var now: Date { get }
}

struct Now: NowRepresentable {
    var now: Date { Date() }
}
