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
        let fakeEvent = Event(id: 0, name: "Great Orchestra", date: fixedDate(), cost: 10.5, booked: false)
        completion(.success(fakeEvent))
    }
    
    // Only cause it's all fake
    fileprivate func fixedDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.date(from: "2022/06/12 10:30")!
    }
}
