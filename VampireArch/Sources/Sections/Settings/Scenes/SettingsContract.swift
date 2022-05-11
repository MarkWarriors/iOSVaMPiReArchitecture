//
//  SettingsContract.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

protocol SettingsPresenterType {
    func setup(with view: SettingsViewControllerType)
    func screenWillAppear()
}

protocol SettingsViewControllerType: AnyObject {
    func config(with viewModel: SettingsViewModel)
}

struct SettingsViewModel {
    let screenTitle: String
    let header: String
}
