//
//  MockHomeRouter.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 12/05/2022.
//

import Foundation
import UIKit
@testable import VampireArch

final class MockHomeRouter: HomeRouterType {
    var navController: NavControllerType
    var childRouter: Router?
    var parentRouter: Router?
    var showHomeScreenCalled = false
    var pushEventsListCalled = false
    var presentEventDetailsCalledId: Int?
    var presentSettingsCalled = false
    
    init(navController: UINavigationController = UINavigationController()) {
        self.navController = navController
    }
    
    func showHomeScreen() {
        showHomeScreenCalled = true
    }
    
    func pushEventsList() {
        pushEventsListCalled = true
    }
    
    func presentEventDetails(eventId: Int) {
        presentEventDetailsCalledId = eventId
    }
    
    func presentSettings() {
        presentSettingsCalled = true
    }
}
