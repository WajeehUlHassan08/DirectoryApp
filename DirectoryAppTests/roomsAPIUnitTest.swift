//
//  roomsAPIUnitTest.swift
//  DirectoryAppTests
//
//  Created by Wajeeh Ul Hassan on 25/08/2022.
//

import XCTest
@testable import DirectoryApp

class roomsAPIUnitTest: XCTestCase {

    func test_getRoomsWithValidURL_returnsValidResponse () {
        
//        ARRANGE
        let urlStr = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/rooms"
        let resource = NetworkManager()
        let expectations = self.expectation(description: "returnsValidResponse")
        
//        ACT
        resource.getData(url: urlStr) { (result: Result<[Room], NetworkError>) in
            
            // ASSERT
            XCTAssertNotNil(result)
            
            switch result {
                
            case .success(let page):
                
                XCTAssertEqual(false, page[0].isOccupied)
                XCTAssertEqual(53539, page[0].maxOccupancy)
                XCTAssertEqual("1", page[0].id)
                expectations.fulfill()
                
                
            case .failure(let error):
                XCTAssertNil(NetworkError.dataFailure)
                XCTAssertNil(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 3, handler: nil)

    }
    
    
    func test_getRoomsWithInvalidURL_returnsInValidResponse_Returns_Error () {
        
//        ARRANGE
        let urlStr = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/roomsx"
        let resource = NetworkManager()
        let expectations = self.expectation(description: "returnsInValidResponse_Error")
        
//        ACT
        resource.getData(url: urlStr) { (result: Result<[Room], NetworkError>) in
            
            // ASSERT
            XCTAssertNotNil(result)
            
            switch result {
                
            case .success(let page):
                
                XCTAssertNil(page)
                
                
            case .failure(let error):
                XCTAssertNotNil(error.localizedDescription)
                
                XCTAssertNotNil(error)
                XCTAssertNotNil(NetworkError.dataFailure)
                expectations.fulfill()
                
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)

    }

}
