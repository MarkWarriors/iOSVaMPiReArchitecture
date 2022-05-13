//
//  AppRouterTests.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 12/05/2022.
//

import Foundation
import XCTest
@testable import VampireArch


final class AppRouterTests: XCTestCase {
    private var subject: AppRouter!
    private var mockNavController: MockNavController!
    
    override func setUp() {
        mockNavController = MockNavController()
        subject = AppRouter(with: mockNavController)
    }
    
    func test_noChildrenRouters_when_subjectStart() {
        then_noChildRouter_and_noScreenShown()
    }
    
    func test_homeRouterIsAddedAsChild_and_homeScreenShown_when_ShowFirstScreenCalled() {
        when_showFirstScreen()
        then_homeRouterIsAddedAsChild_and_homeScreenShown()
    }
    
    // MARK: Given
    
    // MARK: When
    
    private func when_showFirstScreen() {
        subject.showFirstScreen()
    }
    
    // MARK: Then
    
    private func then_noChildRouter_and_noScreenShown() {
        XCTAssertNil(subject.childRouter)
        XCTAssertFalse(mockNavController.setViewControllersCalled)
    }
    
    private func then_homeRouterIsAddedAsChild_and_homeScreenShown() {
        XCTAssertNotNil(subject.childRouter as? HomeRouterType)
        XCTAssertTrue(mockNavController.setViewControllersCalled)
        XCTAssertNotNil(mockNavController.viewControllerArrayPassed?[0] as? HomeViewController)
    }
}
