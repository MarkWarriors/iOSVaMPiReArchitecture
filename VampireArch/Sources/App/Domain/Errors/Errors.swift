//
//  Errors.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidResponseType
    case unexpected
}
