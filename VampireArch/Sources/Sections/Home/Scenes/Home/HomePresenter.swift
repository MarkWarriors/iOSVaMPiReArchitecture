//
//  HomePresenter.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

final class HomePresenter: HomePresenterType {
    private weak var router: HomeRouterType?
    private weak var view: HomeViewControllerType?
    
    private let eventDetailsUseCase: EventDetailsUseCaseType
    private let analyticsManager: AnalyticsManagerType
    private var nextEventId: Int?
    
    init(eventDetailsUseCase: EventDetailsUseCaseType,
         analyticsManager: AnalyticsManagerType,
         router: HomeRouterType) {
        self.eventDetailsUseCase = eventDetailsUseCase
        self.analyticsManager = analyticsManager
        self.router = router
    }
    
    func setup(with view: HomeViewControllerType) {
        self.view = view
        configureView(with: nil)
    }
    
    func screenWillAppear() {
        analyticsManager.sendScreenAppear(named: "Home")
        fetchNextEventDetails()
    }
    
    func eventListButtonTapped() {
        router?.pushEventsList()
    }
    
    func nextEventDetailsButtonTapped() {
        guard let nextEventId = nextEventId else { return }
        router?.presentEventDetails(eventId: nextEventId)
    }
    
    func rightBarButtonTapped() {
        router?.presentSettings()
    }
    
    private func fetchNextEventDetails() {
        view?.showLoadingState()
        eventDetailsUseCase.fetch(eventId: nil) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let event):
                self.handleFetchNextEventDetailSuccess(event: event)
            case .failure(let error):
                self.handleFetchNextEventDetailFailure(error: error)
            }
            self.view?.dismissLoadingState()
        }
    }
    
    private func configureView(with event: Event? = nil) {
        var nextEvent: HomeViewModel.NextEvent?
        if let event = event {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            nextEvent = .init(header: "Next available event",
                              name: event.name,
                              date: dateFormatter.string(from: event.date),
                              price: String(format: "$%.2f", event.cost),
                              showEventButtonTitle: "Show Details")
        }
        
        let viewModel = HomeViewModel(screenTitle: "Home",
                                      header: "Welcome to VaMPiRe Events",
                                      eventListButtonTitle: "Go To Events List",
                                      nextEvent: nextEvent,
                                      rightBarButton: "Settings")
        view?.config(with: viewModel)
    }
    
    private func handleFetchNextEventDetailSuccess(event: Event) {
        nextEventId = event.id
        configureView(with: event)
    }
    
    private func handleFetchNextEventDetailFailure(error: Error) {
        // TODO: its just example
    }
}
