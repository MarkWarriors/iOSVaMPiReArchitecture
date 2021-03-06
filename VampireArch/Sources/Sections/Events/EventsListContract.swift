//
//  EventsListContract.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

protocol EventsListPresenterType {
    func setup(with view: EventsListViewControllerType)
    func screenWillAppear()
    func pullToRefreshTriggered()
    func eventSelected(eventId: Int)
    func rightBarButtonTapped()
}

protocol EventsListViewControllerType: AnyObject {
    func config(with viewModel: EventsListViewModel)
    func showEventsInList(events: [EventListTableViewCellConfig])
    func showLoadingState()
    func dismissLoadingState()
}

struct EventsListViewModel {
    let screenTitle: String
    let rightBarButton: String
}

struct EventListTableViewCellConfig {
    let id: Int
    let name: String
    let price: String
    let booked: String
}
