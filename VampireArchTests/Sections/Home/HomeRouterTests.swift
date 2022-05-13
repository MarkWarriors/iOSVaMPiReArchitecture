//
//  HomeRouterTests.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 13/05/2022.
//

import Foundation
import XCTest
@testable import VampireArch

final class HomeRouterTests: XCTestCase {
    private var subject: HomeRouter!
    private var mockNavController: MockNavController!
    
    override func setUp() {
        mockNavController = MockNavController()
        subject = HomeRouter(with: mockNavController)
    }
    
    func test_noChildrenRouters_when_subjectStart() {
        then_noChildRouter_and_noScreenShown()
    }
    
    func test_homeScreenShown_when_ShowFirstScreenCalled() {
        when_showFirstScreen()
        then_homeScreenShown()
    }
    
    func test_eventsListPushed_when_pushEventsListCalled() {
        when_pushEventsListCalled()
        then_eventsListPushed()
    }
    
    func test_eventDetailsPresented_when_presentEventDetailsCalled() {
        when_presentEventDetailsCalled()
        then_eventDetailsPresented()
    }
    
    func test_settingsPresented_when_presentSettingsCalled() {
        when_presentSettingsCalled()
        then_settingsPresented()
    }
    
    // MARK: Given
    
    // MARK: When
    
    private func when_showFirstScreen() {
        subject.showHomeScreen()
    }
    
    private func when_pushEventsListCalled() {
        subject.pushEventsList()
    }
    
    private func when_presentEventDetailsCalled() {
        subject.presentEventDetails(eventId: 123)
    }
    
    private func when_presentSettingsCalled() {
        subject.presentSettings()
    }
    
    // MARK: Then
    
    private func then_noChildRouter_and_noScreenShown() {
        XCTAssertNil(subject.childRouter)
        XCTAssertFalse(mockNavController.setViewControllersCalled)
    }
    
    private func then_homeScreenShown() {
        XCTAssertNil(subject.childRouter)
        XCTAssertTrue(mockNavController.setViewControllersCalled)
        XCTAssertNotNil(mockNavController.viewControllerArrayPassed?[0] as? HomeViewController)
    }
    
    private func then_eventsListPushed() {
        XCTAssertNotNil(subject.childRouter as? EventRouterType)
        XCTAssertTrue(mockNavController.pushViewControllerCalled)
        XCTAssertNotNil(mockNavController.viewControllerPassed as? EventsListViewController)
    }
    
    private func then_eventDetailsPresented() {
        let childRouter = subject.childRouter as? EventRouterType
        XCTAssertNotNil(childRouter)
        XCTAssertTrue(mockNavController.presentCalled)
        XCTAssertEqual(mockNavController.viewControllerPassed as! UINavigationController,
                       childRouter!.navController as! UINavigationController)
    }
    
    private func then_settingsPresented() {
        let childRouter = subject.childRouter as? SettingsRouterType
        XCTAssertNotNil(childRouter)
        XCTAssertTrue(mockNavController.presentCalled)
        XCTAssertEqual(mockNavController.viewControllerPassed as! UINavigationController,
                       childRouter!.navController as! UINavigationController)
    }
}
