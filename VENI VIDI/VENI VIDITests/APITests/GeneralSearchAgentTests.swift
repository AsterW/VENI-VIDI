//
//  GeneralSearchAgentTests.swift
//  VENI VIDITests
//
//  Created by 雲無心 on 4/13/21.
//

@testable import VENI_VIDI
import UIKit
import XCTest

class GeneralSearchAgentTests: XCTestCase {
    // MARK: - Properties and Set Up

    var generalSearchAgent: GeneralSearchAgent!
    var searchResults: [QueryContentType: [QueryResult]]!
    var expectations: [XCTestExpectation]!

    override func setUpWithError() throws {
        super.setUp()
        generalSearchAgent = GeneralSearchAgent()
        searchResults = [:]
        expectations = []
    }

    override func tearDownWithError() throws {
        expectations = nil
        searchResults = nil
        generalSearchAgent = nil
        super.tearDown()
    }

    // MARK: - Behavior Tests

    func testSearchMovie() throws {
        expectations.append(expectation(description: "Single Movie Search - Interstellar"))
        generalSearchAgent.query(withKeyword: "Interstellar", forContentType: .movie) { [self] result in
            switch result {
            case let .success(results):
                if let contentType = results.first?.type {
                    searchResults[contentType] = results
                }
                expectations.first?.fulfill()
                if !expectations.isEmpty {
                    expectations.removeFirst()
                }
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertGreaterThan(searchResults[.movie]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.tvShow]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.book]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.game]?.count ?? 0, 0)
    }

    func testSearchTVShows() throws {
        expectations.append(expectation(description: "Single TV Show Search - Sense8"))
        generalSearchAgent.query(withKeyword: "Sense8", forContentType: .tvShow) { [self] result in
            switch result {
            case let .success(results):
                if let contentType = results.first?.type {
                    searchResults[contentType] = results
                }
                expectations.first?.fulfill()

                if !expectations.isEmpty {
                    expectations.removeFirst()
                }
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertGreaterThan(searchResults[.tvShow]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.movie]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.book]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.game]?.count ?? 0, 0)
    }

    func testSearchGames() throws {
        expectations.append(expectation(description: "Single Game Search - EVE Online"))
        generalSearchAgent.query(withKeyword: "EVE Online", forContentType: .game) { [self] result in
            switch result {
            case let .success(results):
                if let contentType = results.first?.type {
                    searchResults[contentType] = results
                }
                expectations.first?.fulfill()
                if !expectations.isEmpty {
                    expectations.removeFirst()
                }
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertGreaterThan(searchResults[.game]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.tvShow]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.movie]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.book]?.count ?? 0, 0)
    }

    func testSearchAllCategories() throws {
        for index in 1 ... 3 {
            expectations.append(expectation(description: "Expectation #\(index)"))
        }
        generalSearchAgent.query(withKeyword: "Night") { [self] result in
            switch result {
            case let .success(results):
                if let contentType = results.first?.type {
                    searchResults[contentType] = results
                }
                expectations.first?.fulfill()
                if !expectations.isEmpty {
                    expectations.removeFirst()
                }
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertGreaterThan(searchResults[.tvShow]?.count ?? 0, 0)
        XCTAssertGreaterThan(searchResults[.movie]?.count ?? 0, 0)
        XCTAssertGreaterThan(searchResults[.game]?.count ?? 0, 0)
    }

    // MARK: - Performance Tests

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
