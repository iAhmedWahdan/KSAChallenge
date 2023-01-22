//
//  KSAChallengeTests.swift
//  KSAChallengeTests
//
//  Created by Ahmed Wahdan on 22/01/2023.
//

import XCTest
@testable import KSAChallenge

final class KSAChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        
        NetworkService.shared.getUsersList(page: 1) { result in
            switch result {
            case .success(let users):
                XCTAssertTrue(!users.isEmpty)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Fail: \(error.localizedDescription)")
            }
        }
        wait(for: [expectation], timeout: 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
