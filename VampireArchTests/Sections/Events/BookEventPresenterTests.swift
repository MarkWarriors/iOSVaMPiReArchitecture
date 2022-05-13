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
}

private class MockBookEventViewController: BookEventViewControllerType {
    var configCalledViewModel: BookEventViewModel?
    
    func config(with viewModel: BookEventViewModel) {
        configCalledViewModel = viewModel
    }
}
