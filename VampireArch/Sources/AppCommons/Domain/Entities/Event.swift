//
//  Event.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

struct Event: Codable {
    let id: Int
    let name: String
    let date: Date
    let cost: Double
    let booked: Bool
}
