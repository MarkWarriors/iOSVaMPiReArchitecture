//
//  HomeContract.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

protocol HomePresenterType {
    func setup(with view: HomeViewControllerType)
    func screenWillAppear()
    func eventListButtonTapped()
    func nextEventDetailsButtonTapped()
}

protocol HomeViewControllerType: AnyObject {
    func config(with config: HomeViewConfig)
    func showLoadingState()
    func dismissLoadingState()
}

struct HomeViewConfig {
    let screenTitle: String
    let header: String
    let eventListButtonTitle: String
    let nextEvent: NextEvent?
    
    struct NextEvent {
        let header: String
        let name: String
        let date: String
        let price: String
        let showEventButtonTitle: String
    }
}
