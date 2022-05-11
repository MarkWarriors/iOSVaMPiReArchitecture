//
//  HomeRouter.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import UIKit

protocol HomeRouterType: Router {
    func showHomeScreen()
    func pushEventsList()
    func pushEventDetails(eventId: Int)
}

final class HomeRouter: HomeRouterType {
    let navController: UINavigationController
    var childRouter: Router?
    weak var parentRouter: Router?
    
    init(with navController: UINavigationController) {
        self.navController = navController
    }
    
    func showHomeScreen() {
        let vc = HomeDependencies.shared.homeViewController(router: self)
        navController.setViewControllers([vc], animated: true)
    }
    
    func pushEventsList() {
        let eventRouter = EventRouter(with: navController)
        addChildRouter(router: eventRouter)
        eventRouter.pushEventsList()
    }
    
    func pushEventDetails(eventId: Int) {
        let eventRouter = EventRouter(with: navController)
        addChildRouter(router: eventRouter)
        eventRouter.pushEventDetails(eventId: eventId)
    }
}
