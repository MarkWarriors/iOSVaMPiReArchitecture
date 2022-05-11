//
//  EventsListUseCase.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import Foundation

protocol EventsListUseCaseType {
    func fetch(completion: @escaping (Result<[Event], Error>) -> Void)
}

struct EventsListUseCase: EventsListUseCaseType {
    
    init() {}
    
    public func fetch(completion: @escaping (Result<[Event], Error>) -> Void) {
        // We mock the response given this is just an example
        let fakeEvents = [
            Event(id: 0, name: "Great Orchestra", date: Date(), cost: 10.5, booked: false),
            Event(id: 1, name: "Beautiful Movie", date: Date(), cost: 5, booked: true),
            Event(id: 2, name: "Astonishing Concert", date: Date(), cost: 35, booked: true),
            Event(id: 3, name: "Cooking Show Live", date: Date(), cost: 15.5, booked: false),
            Event(id: 4, name: "Games Awards", date: Date(), cost: 200, booked: true),
            Event(id: 5, name: "9 Hours of Annoying Sounds", date: Date(), cost: 1.5, booked: false),
            Event(id: 6, name: "Something You Like", date: Date(), cost: 105, booked: true)
        ]
        completion(.success(fakeEvents))
    }
    
}
