//
//  EventDetailsUseCase.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

protocol EventDetailsUseCaseType {
    func fetch(eventId: Int?, completion: @escaping (Result<Event, Error>) -> Void)
}

struct EventDetailsUseCase: EventDetailsUseCaseType {
    init() {}
    
    public func fetch(eventId: Int? = nil, completion: @escaping (Result<Event, Error>) -> Void) {
        // We mock the response given this is just an example
        let fakeEvent = Event(id: 0, name: "Great Orchestra", date: Date(), cost: 10.5, booked: false)
        completion(.success(fakeEvent))
    }
    
}
