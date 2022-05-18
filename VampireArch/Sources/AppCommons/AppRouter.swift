//
//  AppRouter.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import UIKit

protocol NavControllerType {
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func popViewController(animated: Bool) -> UIViewController?
    func popToRootViewController(animated: Bool) -> [UIViewController]?
    func setViewControllers(_: [UIViewController], animated: Bool)
    func present(_: UIViewController, animated: Bool, completion: (() -> Void)?)
    func pushViewController(_: UIViewController, animated: Bool)
}

extension UINavigationController: NavControllerType {}

protocol Router: AnyObject {
    var navController: NavControllerType { get }
    var childRouter: Router? { get set }
    var parentRouter: Router? { get set }
    func addChildRouter(router: Router)
    func childDidDismiss()
    func dismiss(animated: Bool)
    func back(animated: Bool)
    func popToRoot(animated: Bool)
}

extension Router {
    func childDidDismiss() {
        childRouter = nil
    }
    
    func addChildRouter(router: Router) {
        router.parentRouter = self
        childRouter = router
    }
    
    func dismiss(animated: Bool) {
        navController.dismiss(animated: animated, completion: nil)
        parentRouter?.childDidDismiss()
    }
    
    func back(animated: Bool) {
        _ = navController.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        _ = navController.popToRootViewController(animated: animated)
    }
}

protocol AppRouterType: Router {
    func showFirstScreen()
}

final class AppRouter: AppRouterType {
    let navController: NavControllerType
    var childRouter: Router?
    weak var parentRouter: Router?
    
    init(with navController: NavControllerType) {
        self.navController = navController
    }
    
    func showFirstScreen() {
        let homeRouter = HomeRouter(with: navController)
        addChildRouter(router: homeRouter)
        homeRouter.showHomeScreen()
    }
}
