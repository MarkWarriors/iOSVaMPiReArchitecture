//
//  BookEventPresenterTests.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation
import XCTest
@testable import VampireArch

final class BookEventPresenterTests: XCTestCase {
    private var mockView: MockBookEventViewController!
    private var subject: BookEventPresenter!
    private var mockEventRouter: MockEventRouter!
    
    override func setUp() {
        mockView = MockBookEventViewController()
        mockEventRouter = MockEventRouter()
        subject = BookEventPresenter(router: mockEventRouter)
    }
    
    func test_when_setupIsCalled() {
        when_setupIsCalled()
    }
    
    func test_when_screenWillAppearCalled() {
        given_setupIsCalled()
        when_screenWillAppearCalled()
        then_viewConfigIsCorrect()
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
    
    // MARK: Then
    
    private func then_viewConfigIsCorrect() {
        XCTAssertEqual(mockView.configCalledViewModel?.screenTitle, "Book Event")
    }
}

private class MockBookEventViewController: BookEventViewControllerType {
    var configCalledViewModel: BookEventViewModel?
    
    func config(with viewModel: BookEventViewModel) {
        configCalledViewModel = viewModel
    }
}
