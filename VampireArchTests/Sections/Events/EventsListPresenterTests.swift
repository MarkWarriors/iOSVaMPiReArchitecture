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
    private var mockEventRouter: MockEventRouter!
    
    override func setUp() {
        mockView = MockEventsListViewController()
        mockEventsListUseCase = MockEventsListUseCase()
        mockEventRouter = MockEventRouter()
        subject = EventsListPresenter(eventsListUseCase: mockEventsListUseCase,
                                      router: mockEventRouter)
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
