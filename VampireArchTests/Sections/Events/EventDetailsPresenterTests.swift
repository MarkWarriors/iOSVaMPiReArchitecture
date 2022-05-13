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
