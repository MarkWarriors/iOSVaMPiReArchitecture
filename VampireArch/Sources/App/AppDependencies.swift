//
//  AppDependencies.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import UIKit

final class AppDependencies {
    static let shared = AppDependencies()
    
    private init() { }
    
    func rootNavigationViewController() -> UINavigationController {
        return UINavigationController()
    }
    
    func eventDetailsUseCase() -> EventDetailsUseCaseType {
        return EventDetailsUseCase()
    }
}
