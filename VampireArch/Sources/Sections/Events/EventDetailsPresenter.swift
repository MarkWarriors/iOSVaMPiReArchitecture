//
//  EventDetailsPresenter.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

final class EventDetailsPresenter: EventDetailsPresenterType {
    private weak var router: EventRouterType?
    private weak var view: EventDetailsViewControllerType?
    
    private let eventId: Int
    private let eventDetailsUseCase: EventDetailsUseCaseType
    
    init(eventId: Int,
         eventDetailsUseCase: EventDetailsUseCaseType,
         router: EventRouterType) {
        self.eventId = eventId
        self.eventDetailsUseCase = eventDetailsUseCase
        self.router = router
    }
    
    func setup(with view: EventDetailsViewControllerType) {
        self.view = view
    }
    
    func screenWillAppear() {
        configureView()
        fetchEventDetail()
    }
    
    func fetchEventDetail() {
        view?.showLoadingState()
        eventDetailsUseCase.fetch(eventId: eventId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let event):
                self.handleFetchEventDetailSuccess(event: event)
            case .failure(let error):
                self.handleFetchEventDetailFailure(error: error)
            }
            self.view?.dismissLoadingState()
        }
    }
    
    private func configureView(with event: Event? = nil) {
        var eventInfo: EventDetailsViewConfig.EventInfo?
        if let event = event {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            eventInfo = .init(id: "Event ID: \(String(event.id))",
                              name: event.name,
                              date: dateFormatter.string(from: event.date),
                              price: String(format: "$%.2f", event.cost),
                              booked: event.booked ? "Booked": "Available")
        }
        
        let config = EventDetailsViewConfig(screenTitle: "Event Details",
                                            eventInfo: eventInfo)
        view?.config(with: config)
    }
    
    private func handleFetchEventDetailSuccess(event: Event) {
        configureView(with: event)
    }
    
    private func handleFetchEventDetailFailure(error: Error) {
        // TODO: its just example
    }
}
