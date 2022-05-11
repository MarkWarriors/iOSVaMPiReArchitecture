//
//  AppRouter.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import UIKit

public protocol Router: AnyObject {
    var navController: UINavigationController { get }
    var childRouter: Router? { get set }
    var parentRouter: Router? { get set }
    func addChildRouter(router: Router)
    func childDidDismiss()
    func dismiss(animated: Bool)
    func back(animated: Bool)
    func popToRoot(animated: Bool)
}

public extension Router {
    func childDidDismiss() {
        childRouter = nil
    }
    
    func addChildRouter(router: Router) {
        router.parentRouter = self
        childRouter = router
    }
    
    func dismiss(animated: Bool) {
        navController.dismiss(animated: animated)
        parentRouter?.childDidDismiss()
    }
    
    func back(animated: Bool) {
        navController.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        navController.popToRootViewController(animated: animated)
    }
}

protocol AppRouterType: Router {
    func showFirstScreen()
}

final class AppRotuer: AppRouterType {
    let navController: UINavigationController
    var childRouter: Router?
    weak var parentRouter: Router?
    
    init(with navController: UINavigationController) {
        self.navController = navController
    }
    
    func showFirstScreen() {
        let homeRouter = HomeRouter(with: navController)
        addChildRouter(router: homeRouter)
        homeRouter.showHomeScreen()
    }
}
