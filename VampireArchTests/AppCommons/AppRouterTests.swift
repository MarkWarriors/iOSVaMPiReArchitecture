//
//  AppRouterTests.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 12/05/2022.
//

import Foundation
import XCTest
@testable import VampireArch


final class AppRouterTests: XCTestCase {
    private var subject: AppRouter!
    private var mockNavController: MockNavController!
    
    override func setUp() {
        mockNavController = MockNavController()
        subject = AppRouter(with: mockNavController)
    }
    
    func test() {
        
    }
}
