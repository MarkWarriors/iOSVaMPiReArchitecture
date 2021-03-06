//
//  SettingsRouter.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import UIKit

protocol SettingsRouterType: Router {
    func pushSettings()
}

final class SettingsRouter: SettingsRouterType {
    let navController: NavControllerType
    var childRouter: Router?
    weak var parentRouter: Router?
    
    init(with navController: NavControllerType) {
        self.navController = navController
    }
    
    func pushSettings() {
        let vc = SettingsDependencies.shared.settingsViewController(router: self)
        navController.pushViewController(vc, animated: true)
    }
}
