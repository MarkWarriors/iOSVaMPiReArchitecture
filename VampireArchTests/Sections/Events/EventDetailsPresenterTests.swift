//
//  EventDetailsPresenterTests.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation
import XCTest
@testable import VampireArch

final class EventDetailsPresenterTests: XCTestCase {
    private var mockView: MockEventDetailsViewController!
    private var subject: EventDetailsPresenter!
    private var mockEventDetailsUseCase: MockEventDetailsUseCase!
    private var mockAnalyticsManager: MockAnalyticsManager!
    private var mockEventRouter: MockEventRouter!
    
    override func setUp() {
        mockView = MockEventDetailsViewController()
        mockEventDetailsUseCase = MockEventDetailsUseCase()
        mockEventRouter = MockEventRouter()
        mockAnalyticsManager = MockAnalyticsManager()
        subject = EventDetailsPresenter(eventId: 123,
                                        eventDetailsUseCase: mockEventDetailsUseCase,
                                        analyticsManager: mockAnalyticsManager,
                                        router: mockEventRouter)
    }
    
    func test_configCorrect_and_noAnalyticsSent_when_setupIsCalled() {
        when_setupIsCalled()
        then_viewConfigIsCorrect(eventInfoPresent: false, eventBooked: false)
        then_analyticsAreNotSent()
    }
    
    func test_analyticsAreSent_when_screenWillAppearCalled() {
        given_setupIsCalled()
        when_screenWillAppearCalled()
        then_analyticsAreSentCorrectlyForScreenWillAppear()
    }
    
    func test_routerPushBookEvent_when_bookEventTappedCalled() {
        given_setupIsCalled()
        when_bookEventTappedCalled()
        then_routerPushBookEvent()
    }
    
    func test_fetchEventDetailsCalled_and_nextEventViewIsShown_when_screenWillAppearCalled_andEventDetailsUseCaseSuccessful_eventBooked() {
        given_setupIsCalled()
        given_fetchEventDetailsSuccessfull(eventBooked: true)
        when_screenWillAppearCalled()
        then_loadingStateShown()
        then_loadingStateDismissed()
        then_fetchEventDetailsCalled()
        then_viewConfigIsCorrect(eventInfoPresent: true, eventBooked: true)
    }
    
    func test_fetchEventDetailsCalled_and_nextEventViewIsShown_when_screenWillAppearCalled_andEventDetailsUseCaseSuccessful_eventNotBooked() {
        given_setupIsCalled()
        given_fetchEventDetailsSuccessfull(eventBooked: false)
        when_screenWillAppearCalled()
        then_loadingStateShown()
        then_loadingStateDismissed()
        then_fetchEventDetailsCalled()
        then_viewConfigIsCorrect(eventInfoPresent: true, eventBooked: false)
    }
    
    func test_fetchEventDetailsCalled_and_nextEventViewIsNotShown_when_screenWillAppearCalled_andEventDetailsUseCaseFailure() {
        given_setupIsCalled()
        given_fetchEventDetailsFailure()
        when_screenWillAppearCalled()
        then_loadingStateShown()
        then_loadingStateDismissed()
        then_fetchEventDetailsCalled()
        then_viewConfigIsCorrect(eventInfoPresent: false, eventBooked: false)
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
    
    private func when_bookEventTappedCalled() {
        subject.bookEventTapped()
    }
    
    private func given_fetchEventDetailsSuccessfull(eventBooked: Bool) {
        mockEventDetailsUseCase.resultToReturn = .success(MockEvent.mock(booked: eventBooked))
    }
    
    private func given_fetchEventDetailsFailure() {
        mockEventDetailsUseCase.resultToReturn = .failure(NetworkError.unexpected)
    }
    
    // MARK: Then
    
    private func then_viewConfigIsCorrect(eventInfoPresent: Bool, eventBooked: Bool) {
        XCTAssertEqual(mockView.configCalledViewModel?.screenTitle, "Event Details")
        if eventInfoPresent {
            XCTAssertEqual(mockView.configCalledViewModel?.bookEventButton, eventBooked ? nil : "Book event")
            let eventInfo = mockView.configCalledViewModel?.eventInfo
            XCTAssertEqual(eventInfo?.booked, eventBooked ? "Booked" : "Available")
            XCTAssertEqual(eventInfo?.price, "$15.50")
            XCTAssertEqual(eventInfo?.name, "EventName")
            XCTAssertEqual(eventInfo?.date, "12 Jun 2022")
            XCTAssertEqual(eventInfo?.id, "Event ID: 1")
        } else {
            XCTAssertNil(mockView.configCalledViewModel?.bookEventButton)
            XCTAssertNil(mockView.configCalledViewModel?.eventInfo)
        }
    }
    
    private func then_analyticsAreSentCorrectlyForScreenWillAppear() {
        XCTAssertEqual(mockAnalyticsManager.sentScreenAppearName, "Event Details")
    }
    
    private func then_analyticsAreNotSent() {
        XCTAssertNil(mockAnalyticsManager.sentScreenAppearName)
    }
    
    private func then_fetchEventDetailsCalled() {
        XCTAssertTrue(mockEventDetailsUseCase.fetchCalled)
    }
    
    private func then_routerPushBookEvent() {
        XCTAssertTrue(mockEventRouter.pushBookEventCalled)
    }
    
    private func then_loadingStateShown() {
        XCTAssertTrue(mockView.showLoadingStateCalled)
    }
    
    private func then_loadingStateDismissed() {
        XCTAssertTrue(mockView.dismissLoadingStateCalled)
    }
}

private class MockEventDetailsViewController: EventDetailsViewControllerType {
    var configCalledViewModel: EventDetailsViewModel?
    var showLoadingStateCalled = false
    var dismissLoadingStateCalled = false
    
    func config(with viewModel: EventDetailsViewModel) {
        configCalledViewModel = viewModel
    }
    
    func showLoadingState() {
        showLoadingStateCalled = true
    }
    
    func dismissLoadingState() {
        dismissLoadingStateCalled = true
    }
}
