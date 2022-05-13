//
//  MockEvent.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation
@testable import VampireArch

final class MockEvent {
    static func mock(id: Int = 1,
                     name: String = "EventName",
                     date: Date = MockDateGenerator.fixedDate(),
                     cost: Double = 15.5,
                     booked: Bool = true) -> Event {
        return Event(id: id,
                     name: name,
                     date: date,
                     cost: cost,
                     booked: booked)
    }
}
