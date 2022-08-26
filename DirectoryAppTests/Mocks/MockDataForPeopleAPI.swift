//
//  MockDataForPeopleAPI.swift
//  DirectoryAppTests
//
//  Created by Wajeeh Ul Hassan on 26/08/2022.
//

import Foundation
@testable import DirectoryApp


class MockPeopleDataAPI {
    var shouldReturnError = false
    var peopleAPIWasCalled = false
    
    func reset() {
        shouldReturnError = false
        peopleAPIWasCalled = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let peopleMockData = [
        "createdAt": "2022-01-24T17:02:23.729Z",
        "firstName": "Maggie",
        "avatar": "https://randomuser.me/api/portraits/women/21.jpg",
        "lastName": "Brekke",
        "email": "Crystel.Nicolas61@hotmail.com",
        "jobtitle": "Future Functionality Strategist",
        "favouriteColor": "pink",
        "id": "1"
    ]
    
}

extension MockPeopleDataAPI {
    
    func getData(url: String, completion: @escaping (Result<[String: String], NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(NetworkError.dataFailure))
        } else {
            completion(.success(peopleMockData))
        }
    }
    

}
