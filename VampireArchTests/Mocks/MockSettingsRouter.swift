//
//  MockSettingsRouter.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 12/05/2022.
//

import Foundation
import UIKit
@testable import VampireArch

final class MockSettingsRouter: SettingsRouterType {
    var navController: NavControllerType
    var childRouter: Router?
    var parentRouter: Router?
    var pushSettingsCalled = false
    
    init(navController: UINavigationController = UINavigationController()) {
        self.navController = navController
    }
    
    func pushSettings() {
        pushSettingsCalled = true
    }
}
