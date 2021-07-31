//
//  SnapshotTest.swift
//  AccessibilitySamplerTests
//
//  Created by Kazuya Ueoka on 2021/07/31.
//

@testable import AccessibilitySampler
import SnapshotTesting
import XCTest

final class SnapshotTest: XCTestCase {
    private let isRecord: Bool = false

    func testSnapshot() {
        let viewController = ColorsViewController()
        assertSnapshot(matching: viewController, as: .image(precision: SnapshotConstants.precision), record: isRecord)
    }
}
