//
//  EventsListPresenterTests.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation
import XCTest
@testable import VampireArch

final class EventsListPresenterTests: XCTestCase {
    private var mockView: MockEventsListViewController!
    private var subject: EventsListPresenter!
    private var mockEventsListUseCase: MockEventsListUseCase!
    private var mockAnalyticsManager: MockAnalyticsManager!
    private var mockEventRouter: MockEventRouter!
    
    override func setUp() {
        mockView = MockEventsListViewController()
        mockEventsListUseCase = MockEventsListUseCase()
        mockEventRouter = MockEventRouter()
        mockAnalyticsManager = MockAnalyticsManager()
        subject = EventsListPresenter(eventsListUseCase: mockEventsListUseCase,
                                      analyticsManager: mockAnalyticsManager,
                                      router: mockEventRouter)
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
    
    func test_routerPresentEventDetails_when_eventIsSelected() {
        given_setupIsCalled()
        when_eventIsSelected(with: 222)
        then_routerPresentEventDetails()
    }
    
    func test_routerPresentSettings_when_rightBarButtonTappedCalled() {
        given_setupIsCalled()
        when_rightBarButtonTappedCalled()
        then_routerPresentSettings()
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
    
    private func when_eventIsSelected(with eventId: Int) {
        subject.eventSelected(eventId: eventId)
    }
    
    private func when_rightBarButtonTappedCalled() {
        subject.rightBarButtonTapped()
    }
    
    // MARK: Then
    
    private func then_viewConfigIsCorrect() {
        XCTAssertEqual(mockView.configCalledViewModel?.screenTitle, "Events List")
    }
    
    private func then_analyticsAreSentCorrectlyForScreenWillAppear() {
        XCTAssertEqual(mockAnalyticsManager.sentScreenAppearName, "Events List")
    }
    
    private func then_analyticsAreNotSent() {
        XCTAssertNil(mockAnalyticsManager.sentScreenAppearName)
    }
    
    private func then_routerPresentEventDetails() {
        XCTAssertEqual(mockEventRouter.pushEventDetailsCalledId, 222)
    }
    
    private func then_routerPresentSettings() {
        XCTAssertTrue(mockEventRouter.presentSettingsCalled)
    }
}

private class MockEventsListViewController: EventsListViewControllerType {
    var configCalledViewModel: EventsListViewModel?
    var showLoadingStateCalled = false
    var dismissLoadingStateCalled = false
    var showEventsInListCalledEvents: [EventListTableViewCellConfig]?
    
    func config(with viewModel: EventsListViewModel) {
        configCalledViewModel = viewModel
    }
    
    func showLoadingState() {
        showLoadingStateCalled = true
    }
    
    func dismissLoadingState() {
        dismissLoadingStateCalled = true
    }
    
    func showEventsInList(events: [EventListTableViewCellConfig]) {
        showEventsInListCalledEvents = events
    }
}
