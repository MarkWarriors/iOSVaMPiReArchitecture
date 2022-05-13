//
//  MockAnalyticsManager.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 13/05/2022.
//

import Foundation
@testable import VampireArch

final class MockAnalyticsManager: AnalyticsManagerType {
    var sentScreenAppearName: String?
    
    func sendScreenAppear(named: String) {
        sentScreenAppearName = named
    }
}
