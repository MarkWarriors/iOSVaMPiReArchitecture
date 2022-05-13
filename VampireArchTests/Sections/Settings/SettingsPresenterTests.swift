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
}

private class MockSettingsViewController: SettingsViewControllerType {
    var configCalledViewModel: SettingsViewModel?
    var showLoadingStateCalled = false
    var dismissLoadingStateCalled = false
    
    func config(with viewModel: SettingsViewModel) {
        configCalledViewModel = viewModel
    }
}
