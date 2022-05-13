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
        then_viewConfigIsCorrect()
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
    
    // MARK: Then
    
    private func then_viewConfigIsCorrect() {
        XCTAssertEqual(mockView.configCalledViewModel?.screenTitle, "Event Details")
    }
    
    private func then_analyticsAreSentCorrectlyForScreenWillAppear() {
        XCTAssertEqual(mockAnalyticsManager.sentScreenAppearName, "Event Details")
    }
    
    private func then_analyticsAreNotSent() {
        XCTAssertNil(mockAnalyticsManager.sentScreenAppearName)
    }
    
    private func then_routerPushBookEvent() {
        XCTAssertTrue(mockEventRouter.pushBookEventCalled)
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
