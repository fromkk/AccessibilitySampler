//
//  AccessibilitySnapshotTest.swift
//  AccessibilitySamplerTests
//
//  Created by Kazuya Ueoka on 2021/07/31.
//

@testable import AccessibilitySampler
import SnapshotTesting
import AccessibilitySnapshot
import XCTest

final class AccessibilitySnapshotTest: XCTestCase {
    private let isRecord: Bool = false

    func testSnapshot() {
        let viewController = ColorsViewController()
        assertSnapshot(matching: viewController, as: .accessibilityImage(showActivationPoints: .always), record: isRecord)
    }
}
