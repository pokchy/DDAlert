//
//  DDAlertTests.swift
//  DDAlertTests
//
//  Created by Thanh Duc Do on 14.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import XCTest
@testable import DDAlert

class DDAlertTests: XCTestCase {

    func testCrashFree() {
        let alert = DDAlert(actions: [])
        alert.loadViewIfNeeded()
        alert.viewDidLayoutSubviews()
        let viewController = UIViewController()
        viewController.present(alert, animated: true)
        alert.dismissAlert()
    }

    func testEmptyAlert() {
        let alert = DDAlert(actions: [])
        XCTAssert(alert.alertView.actionsStackView.arrangedSubviews.isEmpty, "Actions should be empty")
        XCTAssertNil(alert.sourceView, "SourceView should be nil")
        XCTAssertNil(alert.alertView.titleLabel.text, "Title label text should be nil")
    }

    func testAlertWithViewSource() {
        let view = UIView()
        let alert = DDAlert(actions: [], sourceObject: view)
        XCTAssertNotNil(alert.sourceView, "SourceView should not be nil")
    }

    func testAlertWithFailingSource() {
        let object = UIBarButtonItem()
        let alert = DDAlert(actions: [], sourceObject: object)
        XCTAssertNil(alert.sourceView, "SourceView should be nil")
    }

    func testAlertWithTitle() {
        let alert = DDAlert(title: "Test", actions: [])
        XCTAssertEqual(alert.alertView.titleLabel.text, "Test", "Title label text should be 'Test'")
    }

    func testAlertWithMessage() {
        let alert = DDAlert(message: "Test", actions: [])
        XCTAssertEqual(alert.alertView.messageLabel.text, "Test", "Message label text should be 'Test'")
    }

    func testAlertWithAction() {
        let alert = DDAlert(actions: [DDAlertAction(title: "Test")])
        XCTAssertEqual((alert.alertView.actionsStackView.arrangedSubviews.first as? UIButton)?.titleLabel?.text, "Test", "Action label text should be 'Test'")
    }
}
