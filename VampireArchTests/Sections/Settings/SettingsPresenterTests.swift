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
    private var mockSettingsRouter: MockSettingsRouter!
    
    override func setUp() {
        mockView = MockSettingsViewController()
        mockSettingsRouter = MockSettingsRouter()
        subject = SettingsPresenter(router: mockSettingsRouter)
    }
    
    func test_when_setupIsCalled() {
        when_setupIsCalled()
    }
    
    func test_when_screenWillAppearCalled() {
        given_setupIsCalled()
        when_screenWillAppearCalled()
        then_viewConfigIsCorrect()
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
}

private class MockSettingsViewController: SettingsViewControllerType {
    var configCalledViewModel: SettingsViewModel?
    var showLoadingStateCalled = false
    var dismissLoadingStateCalled = false
    
    func config(with viewModel: SettingsViewModel) {
        configCalledViewModel = viewModel
    }
}
