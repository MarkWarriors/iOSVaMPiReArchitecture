//
//  SettingsPresenter.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

final class SettingsPresenter: SettingsPresenterType {
    private weak var router: SettingsRouterType?
    private weak var view: SettingsViewControllerType?
    
    private let analyticsManager: AnalyticsManagerType
    
    init(analyticsManager: AnalyticsManagerType,
         router: SettingsRouterType) {
        self.analyticsManager = analyticsManager
        self.router = router
    }
    
    func setup(with view: SettingsViewControllerType) {
        self.view = view
        let viewModel = SettingsViewModel(screenTitle: "Settings",
                                          header: "Nothing really to see here :)")
        view.config(with: viewModel)
    }
    
    func screenWillAppear() {
        analyticsManager.sendScreenAppear(named: "Settings")
    }
}
