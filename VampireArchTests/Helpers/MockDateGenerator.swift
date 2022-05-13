//
//  MockDateGenerator.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

final class MockDateGenerator {
    static func fixedDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.date(from: "2022/06/12 10:30")!
    }
}
