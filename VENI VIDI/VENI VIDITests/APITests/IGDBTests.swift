//
//  IGDBTests.swift
//  VENI VIDITests
//
//  Created by 雲無心 on 4/13/21.
//

import UIKit
@testable import VENI_VIDI
import XCTest

class IGDBTests: XCTestCase {
    // MARK: - Properties and Set Up

    var igdbAgent: IGDBSearchAgent!

    override func setUpWithError() throws {
        super.setUp()
        igdbAgent = IGDBSearchAgent()
    }

    override func tearDownWithError() throws {
        igdbAgent = nil
        super.tearDown()
    }

    func testExample() throws {}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
