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
    private var mockEventRouter: MockEventRouter!
    
    override func setUp() {
        mockView = MockEventDetailsViewController()
        mockEventDetailsUseCase = MockEventDetailsUseCase()
        mockEventRouter = MockEventRouter()
        subject = EventDetailsPresenter(eventId: 123,
                                        eventDetailsUseCase: mockEventDetailsUseCase,
                                        router: mockEventRouter)
    }
    
    func test_when_setupIsCalled() {
        when_setupIsCalled()
    }
    
    func test_when_screenWillAppearCalled() {
        given_setupIsCalled()
        when_screenWillAppearCalled()
        then_viewConfigIsCorrect()
    }
    
    func test_when_bookEventTappedCalled() {
        when_bookEventTappedCalled()
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
