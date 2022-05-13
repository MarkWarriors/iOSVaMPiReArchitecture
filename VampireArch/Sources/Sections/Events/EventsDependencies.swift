//
//  EventsDependencies.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

final class EventsDependencies {
    static let shared = EventsDependencies()
    
    private init() { }
    
    func eventsListViewController(router: EventRouterType) -> EventsListViewController {
        return EventsListViewController(presenter: eventsListPresenter(router: router))
    }
    
    func eventDetailsViewController(eventId: Int, router: EventRouterType) -> EventDetailsViewController {
        return EventDetailsViewController(presenter: eventDetailsPresenter(eventId: eventId, router: router))
    }
    
    func bookEventViewController(router: EventRouterType) -> BookEventViewController {
        return BookEventViewController(presenter: bookEventPresenter(router: router))
    }
    
    private func eventsListPresenter(router: EventRouterType) -> EventsListPresenterType {
        return EventsListPresenter(eventsListUseCase: eventsListUseCase(),
                                   analyticsManager: analyticsManager(),
                                   router: router)
    }
    
    private func eventDetailsPresenter(eventId: Int, router: EventRouterType) -> EventDetailsPresenterType {
        return EventDetailsPresenter(eventId: eventId,
                                     eventDetailsUseCase: eventDetailsUseCase(),
                                     analyticsManager: analyticsManager(),
                                     router: router)
    }
    
    private func bookEventPresenter(router: EventRouterType) -> BookEventPresenterType {
        return BookEventPresenter(analyticsManager: analyticsManager(),
                                  router: router)
    }
    
    private func eventsListUseCase() -> EventsListUseCaseType {
        return EventsListUseCase()
    }
    
    private func eventDetailsUseCase() -> EventDetailsUseCaseType {
        return AppDependencies.shared.eventDetailsUseCase()
    }
    
    private func analyticsManager() -> AnalyticsManagerType {
        return AppDependencies.shared.analyticsManager()
    }
    
}
