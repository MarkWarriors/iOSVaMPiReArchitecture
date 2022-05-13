//
//  SettingsDependencies.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

final class SettingsDependencies {
    static let shared = SettingsDependencies()
    
    private init() { }
    
    func settingsViewController(router: SettingsRouterType) -> SettingsViewController {
        return SettingsViewController(presenter: settingsPresenter(router: router))
    }

    
    private func settingsPresenter(router: SettingsRouterType) -> SettingsPresenterType {
        return SettingsPresenter(analyticsManager: analyticsManager(), router: router)
    }
    
    private func analyticsManager() -> AnalyticsManagerType {
        return AppDependencies.shared.analyticsManager()
    }
    
}
