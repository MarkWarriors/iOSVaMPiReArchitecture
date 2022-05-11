//
//  EventsRouter.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import UIKit

protocol EventRouterType: Router {
    func pushEventsList()
    func pushEventDetails(eventId: Int)
    func pushBookEvent()
    func presentSettings()
}

final class EventRouter: EventRouterType {
    let navController: UINavigationController
    var childRouter: Router?
    weak var parentRouter: Router?
    
    init(with navController: UINavigationController) {
        self.navController = navController
    }
    
    func pushEventsList() {
        let vc = EventsDependencies.shared.eventsListViewController(router: self)
        navController.pushViewController(vc, animated: true)
    }
    
    func pushEventDetails(eventId: Int) {
        let vc = EventsDependencies.shared.eventDetailsViewController(eventId: eventId,
                                                                      router: self)
        navController.pushViewController(vc, animated: true)
    }
    
    func pushBookEvent() {
        let vc = EventsDependencies.shared.bookEventViewController(router: self)
        navController.pushViewController(vc, animated: true)
    }
    
    
    func presentSettings() {
        let newNavController = UINavigationController()
        let settingsRouter = SettingsRouter(with: newNavController)
        addChildRouter(router: settingsRouter)
        settingsRouter.pushSettings()
        navController.present(newNavController, animated: true, completion: nil)
    }
}
