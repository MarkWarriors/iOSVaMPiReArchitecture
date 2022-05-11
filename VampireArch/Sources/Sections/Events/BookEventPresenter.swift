//
//  BookEventPresenter.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

final class BookEventPresenter: BookEventPresenterType {
    private weak var router: EventRouterType?
    private weak var view: BookEventViewControllerType?
    
    init(router: EventRouterType) {
        self.router = router
    }
    
    func setup(with view: BookEventViewControllerType) {
        self.view = view
    }
    
    func screenWillAppear() {
        view?.config(with: BookEventViewConfig(screenTitle: "Book Event"))
    }
    
}
