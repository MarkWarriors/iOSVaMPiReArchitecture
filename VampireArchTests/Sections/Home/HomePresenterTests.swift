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
    
    func test_when_setupIsCalled() {
        when_setupIsCalled()
    }
    
    func test_when_screenWillAppearCalled() {
        given_setupIsCalled()
        when_screenWillAppearCalled()
        then_viewConfigIsCorrect()
    }
    
    func test_when_eventListButtonTappedCalled() {
        when_eventListButtonTappedCalled()
    }
    
    func test_when_nextEventDetailsButtonTappedCalled() {
        when_nextEventDetailsButtonTappedCalled()
    }
    
    func test_when_rightBarButtonTappedCalled() {
        when_rightBarButtonTappedCalled()
    }
    
    // MARK: Given
    
    private func given_setupIsCalled() {
        subject.setup(with: mockView)
    }
    
    // MARK: When
    
    private func when_setupIsCalled() {
        subject.setup(with: mockView)
    }
    
    private func when_screenWillAppearCalled() {
        subject.screenWillAppear()
    }
    
    private func when_eventListButtonTappedCalled() {
        subject.eventListButtonTapped()
    }
    
    private func when_nextEventDetailsButtonTappedCalled() {
        subject.nextEventDetailsButtonTapped()
    }
    
    private func when_rightBarButtonTappedCalled() {
        subject.rightBarButtonTapped()
    }
    
    // MARK: Then
    
    private func then_viewConfigIsCorrect() {
        XCTAssertEqual(mockView.configCalledViewModel?.screenTitle, "Home")
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
