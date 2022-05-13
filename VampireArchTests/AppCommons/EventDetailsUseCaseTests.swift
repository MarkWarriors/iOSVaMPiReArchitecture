//
//  EventDetailsUseCaseTests.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 13/05/2022.
//

import Foundation
import XCTest
@testable import VampireArch

final class EventDetailsUseCaseTests: XCTestCase {
    private var subject: EventDetailsUseCase!
    private var extpectedResult: Result<[Event], Error>!
    
    override func setUp() {
        subject = EventDetailsUseCase()
    }
    
    func test_alwaysTrueGivenIsAllFake() {
        let expectedEvent = Event(id: 0, name: "Great Orchestra", date: MockDateGenerator.fixedDate(), cost: 10.5, booked: false)
        let expectation = XCTestExpectation(description: "expectedEvent")
        subject.fetch { result in
            if case let .success(event) = result {
                XCTAssertEqual(event.id, expectedEvent.id)
                XCTAssertEqual(event.name, expectedEvent.name)
                XCTAssertEqual(event.date, expectedEvent.date)
                XCTAssertEqual(event.cost, expectedEvent.cost)
                XCTAssertEqual(event.booked, expectedEvent.booked)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
