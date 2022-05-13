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
    
    private let analyticsManager: AnalyticsManagerType
    
    init(analyticsManager: AnalyticsManagerType,
         router: EventRouterType) {
        self.analyticsManager = analyticsManager
        self.router = router
    }
    
    func setup(with view: BookEventViewControllerType) {
        self.view = view
        let viewModel = BookEventViewModel(screenTitle: "Book Event",
                                           header: "Here you can book the event",
                                           bookEventButton: "Book Event")
        view.config(with: viewModel)
    }
    
    func screenWillAppear() {
        analyticsManager.sendScreenAppear(named: "Book Event")
    }
    
}
