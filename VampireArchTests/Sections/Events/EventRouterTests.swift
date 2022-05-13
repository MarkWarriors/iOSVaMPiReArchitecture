//
//  EventRouterTests.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 13/05/2022.
//

import Foundation
import XCTest
@testable import VampireArch

final class EventRouterTests: XCTestCase {
    private var subject: EventRouter!
    private var mockNavController: MockNavController!
    
    override func setUp() {
        mockNavController = MockNavController()
        subject = EventRouter(with: mockNavController)
    }
    
    func test_noChildrenRouters_when_subjectStart() {
        then_noChildRouter_and_noScreenShown()
    }
    
    func test_eventDetailsScreenShown_when_pushEventDetailsCalled() {
        when_pushEventDetailsCalled()
        then_eventDetailsPushed()
    }
    
    func test_eventsListScreenShown_when_pushEventsListCalled() {
        when_pushEventsListCalled()
        then_eventsListPushed()
    }
    
    func test_bookEventScreenShown_when_pushBookEventCalled() {
        when_pushBookEventCalled()
        then_bookEventPushed()
    }
    
    func test_settingsRouterIsAddedAsChild_and_settingsScreenShown_when_presentSettingsCalled() {
        when_presentSettingsCalled()
        then_settingsPresented()
    }
    
    // MARK: Given
    
    // MARK: When
    
    private func when_pushEventDetailsCalled() {
        subject.pushEventDetails(eventId: 123)
    }
    
    private func when_pushEventsListCalled() {
        subject.pushEventsList()
    }
    
    private func when_pushBookEventCalled() {
        subject.pushBookEvent()
    }
    
    private func when_presentSettingsCalled() {
        subject.presentSettings()
    }
    
    // MARK: Then
    
    private func then_noChildRouter_and_noScreenShown() {
        XCTAssertNil(subject.childRouter)
        XCTAssertFalse(mockNavController.setViewControllersCalled)
    }
    
    private func then_eventDetailsPushed() {
        XCTAssertNil(subject.childRouter)
        XCTAssertTrue(mockNavController.pushViewControllerCalled)
        XCTAssertNotNil(mockNavController.viewControllerPassed as? EventDetailsViewController)
    }
    
    private func then_eventsListPushed() {
        XCTAssertNil(subject.childRouter)
        XCTAssertTrue(mockNavController.pushViewControllerCalled)
        XCTAssertNotNil(mockNavController.viewControllerPassed as? EventsListViewController)
    }
    
    private func then_bookEventPushed() {
        XCTAssertNil(subject.childRouter)
        XCTAssertTrue(mockNavController.pushViewControllerCalled)
        XCTAssertNotNil(mockNavController.viewControllerPassed as? BookEventViewController)
    }
    
    private func then_settingsPresented() {
        let childRouter = subject.childRouter as? SettingsRouterType
        XCTAssertNotNil(childRouter)
        XCTAssertTrue(mockNavController.presentCalled)
        XCTAssertEqual(mockNavController.viewControllerPassed as! UINavigationController,
                       childRouter!.navController as! UINavigationController)
    }
}
