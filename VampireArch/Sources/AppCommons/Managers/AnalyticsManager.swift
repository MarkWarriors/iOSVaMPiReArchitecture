//
//  AnalyticsManager.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 13/05/2022.
//

import Foundation

protocol AnalyticsManagerType {
    func sendScreenAppear(named: String)
}

final class AnalyticsManager: AnalyticsManagerType {
    func sendScreenAppear(named: String) {
        // Nothing really happen :D
    }
}
