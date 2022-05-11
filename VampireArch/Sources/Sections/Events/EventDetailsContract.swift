//
//  EventDetailsContract.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

protocol EventDetailsPresenterType {
    func setup(with view: EventDetailsViewControllerType)
    func screenWillAppear()
    func bookEventTapped()
}

protocol EventDetailsViewControllerType: AnyObject {
    func config(with viewModel: EventDetailsViewModel)
    func showLoadingState()
    func dismissLoadingState()
}

struct EventDetailsViewModel {
    let screenTitle: String
    let eventInfo: EventInfo?
    let bookEventButton: String?
    
    struct EventInfo {
        let id: String
        let name: String
        let date: String
        let price: String
        let booked: String
    }
}
