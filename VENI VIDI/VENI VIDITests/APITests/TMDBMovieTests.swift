//
//  TMDBTests.swift
//  VENI VIDITests
//
//  Created by 雲無心 on 4/12/21.
//

@testable import VENI_VIDI
import UIKit
import XCTest

class TMDBMovieTests: XCTestCase {
    // MARK: - Properties and Set Up

    var tmdbMovieAgent: TMDBMovieSearchAgent!

    override func setUpWithError() throws {
        super.setUp()
        tmdbMovieAgent = TMDBMovieSearchAgent()
    }

    override func tearDownWithError() throws {
        tmdbMovieAgent = nil
        super.tearDown()
    }

    // MARK: - Behavior Tests

    func testValidQuery() throws {
        let testExpectation = expectation(description: "TMDB Movie Interstellar test")
        tmdbMovieAgent.query(withKeyword: "Interstellar", withTimeStamp: Date().timeIntervalSince1970) { result in
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
        let testExpectation = expectation(description: "TMDB Movie no result test")
        tmdbMovieAgent.query(withKeyword: "qwerzxcvasdfjlk;", withTimeStamp: Date().timeIntervalSince1970) { result in
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
            let testExpectation = expectation(description: "TMDB Movie Interstellar test")

            tmdbMovieAgent.query(withKeyword: "Interstellar", withTimeStamp: Date().timeIntervalSince1970) { result in
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
    }

    func testPerformanceInvalidQuery() throws {
        measure {
            let testExpectation = expectation(description: "TMDB Movie no result test")

            tmdbMovieAgent.query(withKeyword: "qwerzxcvasdfjlk;",
                                 withTimeStamp: Date().timeIntervalSince1970) { result in
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
