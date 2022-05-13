//
//  HomePresenterTests.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation
import XCTest
@testable import VampireArch

final class HomePresenterTests: XCTestCase {
    private var mockView: MockHomeViewController!
    private var subject: HomePresenter!
    private var mockEventDetailsUseCase: MockEventDetailsUseCase!
    private var mockAnalyticsManager: MockAnalyticsManager!
    private var mockHomeRouter: MockHomeRouter!
    
    override func setUp() {
        mockView = MockHomeViewController()
        mockEventDetailsUseCase = MockEventDetailsUseCase()
        mockHomeRouter = MockHomeRouter()
        mockAnalyticsManager = MockAnalyticsManager()
        subject = HomePresenter(eventDetailsUseCase: mockEventDetailsUseCase,
                                analyticsManager: mockAnalyticsManager,
                                router: mockHomeRouter)
    }
    
    func test_configCorrect_and_noAnalyticsSent_andFetchEventDetailsNotCalled_when_setupIsCalled() {
        when_setupIsCalled()
        then_viewConfigIsCorrect()
        then_analyticsAreNotSent()
        then_fetchEventDetailsNotCalled()
    }
    
    func test_analyticsAreSent_when_screenWillAppearCalled() {
        given_setupIsCalled()
        when_screenWillAppearCalled()
        then_analyticsAreSentCorrectlyForScreenWillAppear()
    }
    
    func test_fetchEventDetailsCalled_and_nextEventViewIsShown_when_screenWillAppearCalled_andEventDetailsUseCaseSuccessful() {
        given_setupIsCalled()
        given_fetchEventDetailsSuccessfull()
        when_screenWillAppearCalled()
        then_fetchEventDetailsCalled()
        then_nextEventViewIsShown()
    }
    
    func test_fetchEventDetailsCalled_and_nextEventViewIsNotShown_when_screenWillAppearCalled_andEventDetailsUseCaseFailure() {
        given_setupIsCalled()
        given_fetchEventDetailsFailure()
        when_screenWillAppearCalled()
        then_fetchEventDetailsCalled()
        then_nextEventViewIsNotShown()
    }
    
    func test_routerPushEventList_when_eventListButtonTappedCalled() {
        given_setupIsCalled()
        when_eventListButtonTappedCalled()
        then_routerPushEventList()
    }
    
    func test_routerPresentEventDetails_when_nextEventDetailsButtonTappedCalled_andEventDetailsUseCaseSuccessfull() {
        given_fetchEventDetailsSuccessfull()
        given_setupIsCalled_andScreenHasAppeared()
        when_nextEventDetailsButtonTappedCalled()
        then_routerPresentEventDetails()
    }
    
    func test_routerPresentEventDetailsNotCalled_when_nextEventDetailsButtonTappedCalled_andEventDetailsUseCaseFailure() {
        given_fetchEventDetailsFailure()
        given_setupIsCalled_andScreenHasAppeared()
        when_nextEventDetailsButtonTappedCalled()
        then_routerPresentEventDetailsNotCalled()
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
    
    private func given_setupIsCalled_andScreenHasAppeared() {
        subject.setup(with: mockView)
        subject.screenWillAppear()
    }
    
    private func given_fetchEventDetailsSuccessfull() {
        mockEventDetailsUseCase.resultToReturn = .success(MockEvent.mock())
    }
    
    private func given_fetchEventDetailsFailure() {
        mockEventDetailsUseCase.resultToReturn = .failure(NetworkError.unexpected)
    }
    
    
    // MARK: When
    
    private func when_setupIsCalled() {
        subject.setup(with: mockView)
    }
    
    private func when_screenWillAppearCalled() {
        subject.screenWillAppear()
    }
    
    private func when_eventListButtonTappedCalled() {
        subject.eventListButtonTapped()
    }
    
    private func when_nextEventDetailsButtonTappedCalled() {
        subject.nextEventDetailsButtonTapped()
    }
    
    private func when_rightBarButtonTappedCalled() {
        subject.rightBarButtonTapped()
    }
    
    // MARK: Then
    
    private func then_viewConfigIsCorrect() {
        XCTAssertEqual(mockView.configCalledViewModel?.screenTitle, "Home")
    }
    
    private func then_analyticsAreSentCorrectlyForScreenWillAppear() {
        XCTAssertEqual(mockAnalyticsManager.sentScreenAppearName, "Home")
    }
    
    private func then_analyticsAreNotSent() {
        XCTAssertNil(mockAnalyticsManager.sentScreenAppearName)
    }
    
    private func then_fetchEventDetailsNotCalled() {
        XCTAssertFalse(mockEventDetailsUseCase.fetchCalled)
    }
    
    private func then_fetchEventDetailsCalled() {
        XCTAssertTrue(mockEventDetailsUseCase.fetchCalled)
    }
    
    private func then_nextEventViewIsShown() {
        XCTAssertNotNil(mockView.configCalledViewModel?.nextEvent)
        let nextEvent = mockView.configCalledViewModel?.nextEvent
        XCTAssertEqual(nextEvent?.header, "Next available event")
        XCTAssertEqual(nextEvent?.price, "$15.50")
        XCTAssertEqual(nextEvent?.name, "EventName")
        XCTAssertEqual(nextEvent?.date, "12 Jun 2022")
        XCTAssertEqual(nextEvent?.showEventButtonTitle, "Show Details")
    }
    
    private func then_nextEventViewIsNotShown() {
        XCTAssertNil(mockView.configCalledViewModel?.nextEvent)
    }
    
    private func then_routerPushEventList() {
        XCTAssertTrue(mockHomeRouter.pushEventsListCalled)
    }
    
    private func then_routerPresentEventDetails() {
        XCTAssertEqual(mockHomeRouter.presentEventDetailsCalledId, 1)
    }
    
    private func then_routerPresentEventDetailsNotCalled() {
        XCTAssertNil(mockHomeRouter.presentEventDetailsCalledId)
    }
    
    private func then_routerPresentSettings() {
        XCTAssertTrue(mockHomeRouter.presentSettingsCalled)
    }
    
}

private class MockHomeViewController: HomeViewControllerType {
    var configCalledViewModel: HomeViewModel?
    var showLoadingStateCalled = false
    var dismissLoadingStateCalled = false
    
    func config(with viewModel: HomeViewModel) {
        configCalledViewModel = viewModel
    }
    
    func showLoadingState() {
        showLoadingStateCalled = true
    }
    
    func dismissLoadingState() {
        dismissLoadingStateCalled = true
    }
}
