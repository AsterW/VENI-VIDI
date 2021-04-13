//
//  GeneralSearchAgentTests.swift
//  VENI VIDITests
//
//  Created by 雲無心 on 4/13/21.
//

import UIKit
@testable import VENI_VIDI
import XCTest

class GeneralSearchAgentTests: XCTestCase, GeneralSearchAgentDeletage {
    // MARK: - Properties and Set Up

    var generalSearchAgent: GeneralSearchAgent!
    var searchResults: [QueryContentType: [QueryResult]]!
    var expectations: [XCTestExpectation]!

    override func setUpWithError() throws {
        super.setUp()
        generalSearchAgent = GeneralSearchAgent()
        generalSearchAgent.deletage = self
        searchResults = [:]
        expectations = []
    }

    override func tearDownWithError() throws {
        expectations = nil
        searchResults = nil
        generalSearchAgent = nil
        super.tearDown()
    }

    // MARK: - GeneralSearchAgentDeletage function

    func receivedQueryResult(_ result: [QueryResult], for queryContentType: QueryContentType) {
        searchResults[queryContentType] = result
        expectations.first?.fulfill()
        expectations.removeFirst()
    }

    // MARK: - Behavior Tests

    func testSearchMovie() throws {
        expectations.append(expectation(description: "Single Movie Search - Interstellar"))
        generalSearchAgent.query(withKeyword: "Interstellar", forContentType: .movie)
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertGreaterThan(searchResults[.movie]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.tvShow]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.book]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.game]?.count ?? 0, 0)
    }

    func testSearchTVShows() throws {
        expectations.append(expectation(description: "Single TV Show Search - Sense8"))
        generalSearchAgent.query(withKeyword: "Sense8", forContentType: .tvShow)
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertGreaterThan(searchResults[.tvShow]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.movie]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.book]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.game]?.count ?? 0, 0)
    }

    func testSearchBooks() throws {
        expectations.append(expectation(description: "Single Book Search - 2001"))
        generalSearchAgent.query(withKeyword: "2001", forContentType: .tvShow)
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertGreaterThan(searchResults[.book]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.tvShow]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.movie]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.game]?.count ?? 0, 0)
    }

    func testSearchGames() throws {
        expectations.append(expectation(description: "Single Game Search - EVE Online"))
        generalSearchAgent.query(withKeyword: "EVE Online", forContentType: .game)
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertGreaterThan(searchResults[.game]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.tvShow]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.movie]?.count ?? 0, 0)
        XCTAssertEqual(searchResults[.book]?.count ?? 0, 0)
    }

    func testSearchAllCategories() throws {
        for i in 1 ... 4 {
            expectations.append(expectation(description: "Expectation #\(i)"))
        }
        generalSearchAgent.query(withKeyword: "Night")
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertGreaterThan(searchResults[.tvShow]?.count ?? 0, 0)
        XCTAssertGreaterThan(searchResults[.movie]?.count ?? 0, 0)
        XCTAssertGreaterThan(searchResults[.game]?.count ?? 0, 0)
        XCTAssertGreaterThan(searchResults[.book]?.count ?? 0, 0)
    }

    func testConsecutiveSearch() throws {
        for i in 1 ... 2 {
            expectations.append(expectation(description: "Expectation #\(i)"))
        }

        generalSearchAgent.query(withKeyword: "Apple")
        let timeStamp = Date().timeIntervalSince1970
        generalSearchAgent.query(withKeyword: "Apple")
        waitForExpectations(timeout: 10, handler: nil)

        let results = searchResults.map { _, value in value }.reduce([], +)
        for result in results {
            XCTAssertGreaterThan(result.timeStamp, timeStamp)
        }
    }

    // MARK: - Performance Tests

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
