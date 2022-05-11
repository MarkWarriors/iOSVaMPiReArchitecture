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
}

protocol EventDetailsViewControllerType: AnyObject {
    func config(with config: EventDetailsViewConfig)
    func showLoadingState()
    func dismissLoadingState()
}

struct EventDetailsViewConfig {
    let screenTitle: String
    let eventInfo: EventInfo?
    
    struct EventInfo {
        let id: String
        let name: String
        let date: String
        let price: String
        let booked: String
    }
}
