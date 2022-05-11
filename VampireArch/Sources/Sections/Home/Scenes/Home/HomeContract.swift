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
    func rightBarButtonTapped()
}

protocol HomeViewControllerType: AnyObject {
    func config(with viewModel: HomeViewModel)
    func showLoadingState()
    func dismissLoadingState()
}

struct HomeViewModel {
    let screenTitle: String
    let header: String
    let eventListButtonTitle: String
    let nextEvent: NextEvent?
    let rightBarButton: String
    
    struct NextEvent {
        let header: String
        let name: String
        let date: String
        let price: String
        let showEventButtonTitle: String
    }
}
