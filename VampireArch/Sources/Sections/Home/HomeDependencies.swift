//
//  HomeDependencies.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

final class HomeDependencies {
    static let shared = HomeDependencies()
    
    private init() { }
    
    func homeViewController(router: HomeRouterType) -> HomeViewController {
        return HomeViewController(presenter: homePresenter(router: router))
    }
    
    private func homePresenter(router: HomeRouterType) -> HomePresenterType {
        return HomePresenter(eventDetailsUseCase: eventDetailsUseCase(),
                             router: router)
    }
    
    private func eventDetailsUseCase() -> EventDetailsUseCaseType {
        return AppDependencies.shared.eventDetailsUseCase()
    }
}
