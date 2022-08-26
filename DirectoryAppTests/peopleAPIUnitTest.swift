//
//  peopleAPIUnitTest.swift
//  DirectoryAppTests
//
//  Created by Wajeeh Ul Hassan on 25/08/2022.
//

import XCTest
@testable import DirectoryApp

class peopleAPIUnitTest: XCTestCase {

    func test_getPeopleWithValidURL_returnsValidResponse () {
        
//      ARRANGE
        let urlStr = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/people"
        let resource = NetworkManager()
        let expectations = self.expectation(description: "returnsValidResponse")
        
//      ACT
        resource.getData(url: urlStr) { (result: Result<[Person], NetworkError>) in
            
//          ASSERT
            XCTAssertNotNil(result)
            
            switch result {
                
                case .success(let page):
                    XCTAssertEqual("Maggie", page[0].firstName)
                    XCTAssertEqual("Crystel.Nicolas61@hotmail.com", page[0].email)
                    XCTAssertEqual("1", page[0].id)
                    expectations.fulfill()
                    
                case .failure(let error):
                    XCTAssertNil(NetworkError.dataFailure)
                    XCTAssertNil(error)
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)

    }
    
    
    func test_getPeopleWithInvalidURL_returnsInValidResponse_Returns_Error () {
        
//        ARRANGE
        let urlStr = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/peoplex"
        let resource = NetworkManager()
        
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
                    XCTFail(error.localizedDescription)
            }
        }
        
//        waitForExpectations(timeout: 3, handler: nil)

    }

}
