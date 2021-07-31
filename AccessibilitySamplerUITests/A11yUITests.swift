//
//  A11yUITests.swift
//  AccessibilitySamplerUITests
//
//  Created by Kazuya Ueoka on 2021/07/31.
//

import XCTest
import A11yUITests

final class A11yUITests: XCTestCase {
    let application = XCUIApplication()

    func testColors() {
        application.launch()
        let tableView = application.tables["tableView"]
        let colorsCell = tableView.cells["colors"]
        colorsCell.tap()
        let buttons = application.buttons.allElementsBoundByIndex.filter { !$0.identifier.isEmpty }
        a11y(tests: a11yTestSuiteInteractive, on: buttons)
    }
}
