//
//  BookEventContract.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

protocol BookEventPresenterType {
    func setup(with view: BookEventViewControllerType)
    func screenWillAppear()
}

protocol BookEventViewControllerType: AnyObject {
    func config(with config: BookEventViewConfig)
}

struct BookEventViewConfig {
    let screenTitle: String
    let header: String
    let bookEventButton: String
}
