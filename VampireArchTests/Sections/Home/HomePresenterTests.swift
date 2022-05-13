//
//  HomePresenterTests.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation
import XCTest
@testable import VampireArch

final class HomePresenterTests: XCTestCase {
    private var mockView: MockHomeViewController!
    private var subject: HomePresenter!
    private var mockEventDetailsUseCase: MockEventDetailsUseCase!
    private var mockHomeRouter: MockHomeRouter!
    
    override func setUp() {
        mockView = MockHomeViewController()
        mockEventDetailsUseCase = MockEventDetailsUseCase()
        mockHomeRouter = MockHomeRouter()
        subject = HomePresenter(eventDetailsUseCase: mockEventDetailsUseCase,
                                router: mockHomeRouter)
    }
}

private class MockHomeViewController: HomeViewControllerType {
    var configCalledViewModel: HomeViewModel?
    var showLoadingStateCalled = false
    var dismissLoadingStateCalled = false
    
    func config(with viewModel: HomeViewModel) {
        configCalledViewModel = viewModel
    }
    
    func showLoadingState() {
        showLoadingStateCalled = true
    }
    
    func dismissLoadingState() {
        dismissLoadingStateCalled = true
    }
}
