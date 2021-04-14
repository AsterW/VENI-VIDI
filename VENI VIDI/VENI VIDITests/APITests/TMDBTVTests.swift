//
//  TMDBTVTests.swift
//  VENI VIDITests
//
//  Created by 雲無心 on 4/13/21.
//

import UIKit
@testable import VENI_VIDI
import XCTest

class TMDBTVTests: XCTestCase {
    // MARK: - Properties and Set Up

    var tmdbTVAgent: TMDBTVSearchAgent!

    override func setUpWithError() throws {
        super.setUp()
        tmdbTVAgent = TMDBTVSearchAgent()
    }

    override func tearDownWithError() throws {
        tmdbTVAgent = nil
        super.tearDown()
    }

    // MARK: - Behavior Tests

    func testValidQuery() throws {
        let testExpectation = expectation(description: "TMDB TV Show Sense8 test")
        tmdbTVAgent.query(withKeyword: "Sense8", withTimeStamp: Date().timeIntervalSince1970) {
            result in
            switch result {
            case let .success(queryResult):
                XCTAssertGreaterThan(queryResult.count, 0)
                testExpectation.fulfill()
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testInvalidQuery() throws {
        let testExpectation = expectation(description: "TMDB TV Show no result test")

        tmdbTVAgent.query(withKeyword: "qwerzxcvasdfjlk;", withTimeStamp: Date().timeIntervalSince1970) {
            result in
            switch result {
            case let .success(queryResult):
                XCTAssertEqual(queryResult.count, 0)
                testExpectation.fulfill()
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    // MARK: - Performance Tests

    func testPerformanceValidQuery() throws {
        measure {
            let testExpectation = expectation(description: "TMDB TV Show Sense8 test")

            tmdbTVAgent.query(withKeyword: "Sense8", withTimeStamp: Date().timeIntervalSince1970) {
                result in
                switch result {
                case let .success(queryResult):
                    XCTAssertGreaterThan(queryResult.count, 0)
                    testExpectation.fulfill()
                case let .failure(error):
                    print(error.localizedDescription)
                    XCTFail()
                }
            }

            waitForExpectations(timeout: 10, handler: nil)
        }
    }

    func testPerformanceInvalidQuery() throws {
        measure {
            let testExpectation = expectation(description: "TMDB TV Show no result test")

            tmdbTVAgent.query(withKeyword: "qwerzxcvasdfjlk;", withTimeStamp: Date().timeIntervalSince1970) {
                result in
                switch result {
                case let .success(queryResult):
                    XCTAssertEqual(queryResult.count, 0)
                    testExpectation.fulfill()
                case let .failure(error):
                    XCTFail(error.localizedDescription)
                }
            }

            waitForExpectations(timeout: 10, handler: nil)
        }
    }
}
