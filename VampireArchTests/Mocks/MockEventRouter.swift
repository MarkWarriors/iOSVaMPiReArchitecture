//
//  MockEventRouter.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 12/05/2022.
//

import Foundation
import UIKit
@testable import VampireArch

final class MockEventRouter: EventRouterType {
    var navController: NavControllerType
    var childRouter: Router?
    var parentRouter: Router?
    var pushEventDetailsCalledId: Int?
    var pushBookEventCalled = false
    var pushEventsListCalled = false
    var presentSettingsCalled = false
    
    init(navController: UINavigationController = UINavigationController()) {
        self.navController = navController
    }
    
    func pushEventDetails(eventId: Int) {
        pushEventDetailsCalledId = eventId
    }
    
    func pushBookEvent() {
        pushBookEventCalled = true
    }
    
    func pushEventsList() {
        pushEventsListCalled = true
    }
    
    func presentSettings() {
        presentSettingsCalled = true
    }
}
