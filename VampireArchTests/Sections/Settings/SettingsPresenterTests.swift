//
//  SettingsPresenterTests.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation
import XCTest
@testable import VampireArch

final class SettingsPresenterTests: XCTestCase {
    private var mockView: MockSettingsViewController!
    private var subject: SettingsPresenter!
    private var mockAnalyticsManager: MockAnalyticsManager!
    private var mockSettingsRouter: MockSettingsRouter!
    
    override func setUp() {
        mockView = MockSettingsViewController()
        mockSettingsRouter = MockSettingsRouter()
        mockAnalyticsManager = MockAnalyticsManager()
        subject = SettingsPresenter(analyticsManager: mockAnalyticsManager,
                                    router: mockSettingsRouter)
    }
    
    func test_configCorrect_and_noAnalyticsSent_when_setupIsCalled() {
        when_setupIsCalled()
        then_viewConfigIsCorrect()
        then_analyticsAreNotSent()
    }
    
    func test_analyticsAreSent_when_screenWillAppearCalled() {
        given_setupIsCalled()
        when_screenWillAppearCalled()
        then_analyticsAreSentCorrectlyForScreenWillAppear()
    }
    
    // MARK: Given
    
    private func given_setupIsCalled() {
        subject.setup(with: mockView)
    }
    
    // MARK: When
    
    private func when_setupIsCalled() {
        subject.setup(with: mockView)
    }
    
    private func when_screenWillAppearCalled() {
        subject.screenWillAppear()
    }
    
    // MARK: Then
    
    private func then_viewConfigIsCorrect() {
        XCTAssertEqual(mockView.configCalledViewModel?.screenTitle, "Settings")
    }
    
    private func then_analyticsAreSentCorrectlyForScreenWillAppear() {
        XCTAssertEqual(mockAnalyticsManager.sentScreenAppearName, "Settings")
    }
    
    private func then_analyticsAreNotSent() {
        XCTAssertNil(mockAnalyticsManager.sentScreenAppearName)
    }
}

private class MockSettingsViewController: SettingsViewControllerType {
    var configCalledViewModel: SettingsViewModel?
    var showLoadingStateCalled = false
    var dismissLoadingStateCalled = false
    
    func config(with viewModel: SettingsViewModel) {
        configCalledViewModel = viewModel
    }
}
