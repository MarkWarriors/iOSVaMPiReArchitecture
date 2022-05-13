//
//  EventsListUseCaseTests.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 13/05/2022.
//

import Foundation
import XCTest
@testable import VampireArch

final class EventsListUseCaseTests: XCTestCase {
    private var subject: EventsListUseCase!
    private var extpectedResult: Result<[Event], Error>!
    
    override func setUp() {
        subject = EventsListUseCase()
    }
    
    func test_alwaysTrueGivenIsAllFake() {
        let expectedEvents = [
            Event(id: 0, name: "Great Orchestra", date: MockDateGenerator.fixedDate(), cost: 10.5, booked: false),
            Event(id: 1, name: "Beautiful Movie", date: MockDateGenerator.fixedDate(), cost: 5, booked: true),
            Event(id: 2, name: "Astonishing Concert", date: MockDateGenerator.fixedDate(), cost: 35, booked: true),
            Event(id: 3, name: "Cooking Show Live", date: MockDateGenerator.fixedDate(), cost: 15.5, booked: false),
            Event(id: 4, name: "Games Awards", date: MockDateGenerator.fixedDate(), cost: 200, booked: true),
            Event(id: 5, name: "9 Hours of Annoying Sounds", date: MockDateGenerator.fixedDate(), cost: 1.5, booked: false),
            Event(id: 6, name: "Something You Like", date: MockDateGenerator.fixedDate(), cost: 105, booked: true)
        ]
        let expectation = XCTestExpectation(description: "expectedEvents")
        subject.fetch { result in
            if case let .success(events) = result {
                XCTAssertEqual(events.count, expectedEvents.count)
                for (index, event) in events.enumerated() {
                    let expectedEvent = expectedEvents[index]
                    XCTAssertEqual(event.id, expectedEvent.id)
                    XCTAssertEqual(event.name, expectedEvent.name)
                    XCTAssertEqual(event.date, expectedEvent.date)
                    XCTAssertEqual(event.cost, expectedEvent.cost)
                    XCTAssertEqual(event.booked, expectedEvent.booked)
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
