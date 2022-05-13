//
//  MockEventDetailsUseCase.swift
//  VampireArchTests
//
//  Created by Marco Guerrieri on 12/05/2022.
//

import Foundation
@testable import VampireArch

final class MockEventDetailsUseCase: EventDetailsUseCaseType {
    var resultToReturn: Result<Event, Error> = .failure(NetworkError.unexpected)
    var fetchCalled = false
    
    func fetch(eventId: Int?, completion: @escaping (Result<Event, Error>) -> Void) {
        fetchCalled = true
        completion(resultToReturn)
    }    
}
