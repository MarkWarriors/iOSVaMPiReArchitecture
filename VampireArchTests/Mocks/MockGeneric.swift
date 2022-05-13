//
//  MockGeneric.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 13/05/2022.
//

import Foundation
@testable import VampireArch
import UIKit

final class MockNavController: NavControllerType {
    var dismissCalled = false
    var popViewControllerCalled = false
    var popToRootViewControllerCalled = false
    var setViewControllersCalled = false
    var presentCalled = false
    var pushViewControllerCalled = false
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        dismissCalled = true
    }
    
    func popViewController(animated: Bool) -> UIViewController? {
        popViewControllerCalled = true
        return UIViewController()
    }
    
    func popToRootViewController(animated: Bool) -> [UIViewController]? {
        popToRootViewControllerCalled = true
        return []
    }
    
    func setViewControllers(_: [UIViewController], animated: Bool) {
        setViewControllersCalled = true
    }
    
    func present(_: UIViewController, animated: Bool, completion: (() -> Void)?) {
        presentCalled = true
        completion?()
    }
    
    func pushViewController(_: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
    }
    
}
