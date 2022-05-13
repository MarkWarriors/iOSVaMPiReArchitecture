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
    
    func test_backCalledOnNavController_when_backCalled() {
        when_backCalled()
        then_backCalledOnNavController()
    }
    
    func test_dismissCalledOnNavController_when_dismissCalled() {
        when_dismissCalled()
        then_dismissCalledOnNavController()
    }
    
    func test_popToRootCalledOnNavController_when_popToRootCalled() {
        when_popToRootCalled()
        then_popToRootCalledOnNavController()
    }
    
    func test_childRouterIsNotNil_when_addChildRouterCalled() {
        given_childRouterIsNil()
        when_addChildRouterCalled()
        then_childRouterIsNotNil()
    }
    
    func test_childRouterIsNil_when_childDidDismissCalled() {
        given_childRouterNotNil()
        when_childDidDismissCalled()
        then_childRouterIsNil()
    }
    
    // MARK: Given
    
    private func given_childRouterNotNil() {
        subject.childRouter = MockHomeRouter()
    }
    
    private func given_childRouterIsNil() {
        subject.childRouter = nil
    }
    
    // MARK: When
    
    private func when_showFirstScreen() {
        subject.showFirstScreen()
    }
   
    private func when_backCalled() {
        subject.back(animated: false)
    }
    
    private func when_dismissCalled() {
        subject.dismiss(animated: false)
    }
    
    private func when_popToRootCalled() {
        subject.popToRoot(animated: false)
    }
    
    private func when_addChildRouterCalled() {
        subject.addChildRouter(router: EventRouter(with: UINavigationController()))
    }
    
    private func when_childDidDismissCalled() {
        subject.childDidDismiss()
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
    
    private func then_backCalledOnNavController() {
        XCTAssertTrue(mockNavController.popViewControllerCalled)
    }
    
    private func then_dismissCalledOnNavController() {
        XCTAssertTrue(mockNavController.dismissCalled)
    }
    
    private func then_popToRootCalledOnNavController() {
        XCTAssertTrue(mockNavController.popToRootViewControllerCalled)
    }
    
    private func then_childRouterIsNotNil() {
        XCTAssertNotNil(subject.childRouter)
    }
    
    private func then_childRouterIsNil() {
        XCTAssertNil(subject.childRouter)
    }
}
