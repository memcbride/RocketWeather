// ------------------------------------------------------
// Project: RocketWeather
// File: RocketWeatherUITestsLaunchTests.swift
// Created by Mark McBride on 2024.09.05
// Last Updated:  2024.09.05
// GitHub: https://github.com/memcbride
// ------------------------------------------------------
// Copyright © 2024 by MacModeler.  All rights reserved.


import XCTest

final class RocketWeatherUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
