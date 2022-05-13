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
    
    func test_fetchEventsListCalled_and_eventsShown_when_screenWillAppearCalled_andEventDetailsUseCaseSuccessful() {
        given_setupIsCalled()
        given_fetchEventsListSuccessfull()
        when_screenWillAppearCalled()
        then_loadingStateShown()
        then_loadingStateDismissed()
        then_fetchEventsListCalled()
        then_eventsShown()
    }
    
    func test_fetchEventsListCalled_and_eventsNotShown_when_screenWillAppearCalled_andEventDetailsUseCaseFailure() {
        given_setupIsCalled()
        given_fetchEventsListFailure()
        when_screenWillAppearCalled()
        then_loadingStateShown()
        then_loadingStateDismissed()
        then_fetchEventsListCalled()
        then_eventsNotShown()
    }
    
    func test_fetchEventsListCalled_and_eventsShown_when_pullToRefreshTriggered_andEventDetailsUseCaseSuccessful() {
        given_setupIsCalled()
        given_fetchEventsListSuccessfull()
        when_pullToRefreshTriggered()
        then_loadingStateShown()
        then_loadingStateDismissed()
        then_fetchEventsListCalled()
        then_eventsShown()
    }
    
    func test_fetchEventsListCalled_and_eventsNotShown_when_pullToRefreshTriggered_andEventDetailsUseCaseFailure() {
        given_setupIsCalled()
        given_fetchEventsListFailure()
        when_pullToRefreshTriggered()
        then_loadingStateShown()
        then_loadingStateDismissed()
        then_fetchEventsListCalled()
        then_eventsNotShown()
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
    
    private func given_fetchEventsListSuccessfull() {
        mockEventsListUseCase.resultToReturn = .success([MockEvent.mock(name: "first"),
                                                         MockEvent.mock(name: "second"),
                                                         MockEvent.mock(name: "third")])
    }
    
    private func given_fetchEventsListFailure() {
        mockEventsListUseCase.resultToReturn = .failure(NetworkError.unexpected)
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
    
    private func when_pullToRefreshTriggered() {
        subject.pullToRefreshTriggered()
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
    
    private func then_fetchEventsListCalled() {
        XCTAssertTrue(mockEventsListUseCase.fetchCalled)
    }
    
    private func then_eventsShown() {
        XCTAssertEqual(mockView.showEventsInListCalledEvents?.count, 3)
        XCTAssertEqual(mockView.showEventsInListCalledEvents![0].name, "first")
        XCTAssertEqual(mockView.showEventsInListCalledEvents![1].name, "second")
        XCTAssertEqual(mockView.showEventsInListCalledEvents![2].name, "third")
    }
    
    private func then_eventsNotShown() {
        XCTAssertNil(mockView.showEventsInListCalledEvents)
    }
    
    private func then_loadingStateShown() {
        XCTAssertTrue(mockView.showLoadingStateCalled)
    }
    
    private func then_loadingStateDismissed() {
        XCTAssertTrue(mockView.dismissLoadingStateCalled)
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
