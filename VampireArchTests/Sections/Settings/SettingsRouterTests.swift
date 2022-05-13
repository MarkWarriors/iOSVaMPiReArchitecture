//
//  SettingsRouterTests.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 13/05/2022.
//

import Foundation
import XCTest
@testable import VampireArch

final class SettingsRouterTests: XCTestCase {
    private var subject: SettingsRouter!
    private var mockNavController: MockNavController!
    
    override func setUp() {
        mockNavController = MockNavController()
        subject = SettingsRouter(with: mockNavController)
    }
    
    func test_noChildrenRouters_when_subjectStart() {
        then_noChildRouter_and_noScreenShown()
    }
    
    func test_settingsPushed_when_pushSettingsCalled() {
        when_pushSettingsCalled()
        then_settingsPushed()
    }
    
    // MARK: Given
    
    // MARK: When
    
    private func when_pushSettingsCalled() {
        subject.pushSettings()
    }
    
    // MARK: Then
    
    private func then_noChildRouter_and_noScreenShown() {
        XCTAssertNil(subject.childRouter)
        XCTAssertFalse(mockNavController.setViewControllersCalled)
    }
    
    private func then_settingsPushed() {
        XCTAssertNil(subject.childRouter)
        XCTAssertTrue(mockNavController.pushViewControllerCalled)
        XCTAssertNotNil(mockNavController.viewControllerPassed as? SettingsViewController)
    }
}
