//
//  EventsListPresenter.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

final class EventsListPresenter: EventsListPresenterType {
    private weak var router: EventRouterType?
    private weak var view: EventsListViewControllerType?
    
    private let eventsListUseCase: EventsListUseCaseType
    
    init(eventsListUseCase: EventsListUseCaseType,
         router: EventRouterType) {
        self.eventsListUseCase = eventsListUseCase
        self.router = router
    }
    
    func setup(with view: EventsListViewControllerType) {
        self.view = view
    }
    
    func screenWillAppear() {
        let viewModel = EventsListViewModel(screenTitle: "Events List",
                                            rightBarButton: "Settings")
        view?.config(with: viewModel)
        fetchEventsToShow()
    }
    
    func pullToRefreshTriggered() {
        fetchEventsToShow()
    }
    
    func eventSelected(eventId: Int) {
        router?.pushEventDetails(eventId: eventId)
    }
    
    func rightBarButtonTapped() {
        router?.presentSettings()
    }
    
    private func fetchEventsToShow() {
        view?.showLoadingState()
        eventsListUseCase.fetch { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let events):
                self.handleSuccessFetchEventsToShow(with: events)
            case .failure(let error):
                self.handleFailureFetchEventsToShow(with: error)
            }
            self.view?.dismissLoadingState()
        }
    }
    
    private func handleSuccessFetchEventsToShow(with events: [Event]) {
        let eventsToShow = events.map { EventListTableViewCellConfig(id: $0.id,
                                                                     name: $0.name,
                                                                     price: String(format: "$%.2f", $0.cost),
                                                                     booked: $0.booked ? "Booked" : "Available") }
        view?.showEventsInList(events: eventsToShow)
    }
    
    private func handleFailureFetchEventsToShow(with error: Error) {
        // TODO: Call to show error on view passing an error view config struct
    }
}
