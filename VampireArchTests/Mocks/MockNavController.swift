//
//  MockNavController.swift
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
    var viewControllerPassed: UIViewController?
    var viewControllerArrayPassed: [UIViewController]?
    
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
    
    func setViewControllers(_ vc: [UIViewController], animated: Bool) {
        viewControllerArrayPassed = vc
        setViewControllersCalled = true
    }
    
    func present(_ vc: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewControllerPassed = vc
        presentCalled = true
        completion?()
    }
    
    func pushViewController(_ vc: UIViewController, animated: Bool) {
        viewControllerPassed = vc
        pushViewControllerCalled = true
    }
    
}
