//
//  SceneDelegate.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var appRouter: AppRouterType?
    private var rootNavigationController: UINavigationController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let rootNavController = AppDependencies.shared.rootNavigationViewController()
        
        rootNavigationController = rootNavController
        
        appRouter = AppRotuer(with: rootNavController)
        appRouter?.showFirstScreen()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }

}

