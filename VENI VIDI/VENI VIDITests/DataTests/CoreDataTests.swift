//
//  CoreDataTest.swift
//  VENI VIDITests
//
//  Created by 雲無心 on 3/13/21.
//
//  Tutorial copywrite info below
//
/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:

@testable import VENI_VIDI
import UIKit
import XCTest

class CoreDataTests: XCTestCase {
    // MARK: - Properties and Set Up

    var coreDataStack: CoreDataStack!
    var journalEntryService: JournalEntryService!

    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        journalEntryService = JournalEntryService(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
    }
    
    // MARK: - Journal Entry Test Cases
    
    func testCreateJournalEntry() {
        let entry0 = journalEntryService.createJournalEntry()
        XCTAssertNotNil(entry0, "Entry0 should not be nil")
        XCTAssertNotNil(entry0.startDate)
        XCTAssertNotNil(entry0.finishDate)
        XCTAssertTrue(entry0.worksTitle == "")
        XCTAssertTrue(entry0.entryTitle == "")
        XCTAssertTrue(entry0.entryContent == "")
        XCTAssertTrue(entry0.longitude == 0)
        XCTAssertTrue(entry0.latitude == 0)
        XCTAssertTrue(entry0.tags?.count == 0)
        XCTAssertTrue(entry0.favorite == false)
        
        let date1 = Date(timeIntervalSince1970: 10080)
        let date2 = Date(timeIntervalSince1970: 10080)
        let tag1 = journalEntryService.createNewTag("Badass")
        let tag2 = journalEntryService.createNewTag("Superhero")
        let image1 = UIImage(named: "TestImage1")
        let entry1 = journalEntryService.createJournalEntry(aboutWork: "Batman",
                                                            withCoverImage: image1,
                                                            withStartDate: date1,
                                                            withFinishDate: date2,
                                                            withEntryTitle: "Okay that's cool",
                                                            withEntryContent: "Very very cool",
                                                            atLongitude: 1.11,
                                                            atLatitude: -2.22,
                                                            withTags: [tag1, tag2],
                                                            isFavorite: true)
        XCTAssertNotNil(entry1, "Entry1 should not be nil")
        XCTAssertTrue(entry1.worksTitle == "Batman")
        XCTAssertNotNil(entry1.image)
        XCTAssertTrue(entry1.startDate == date1)
        XCTAssertTrue(entry1.finishDate == date2)
        XCTAssertTrue(entry1.entryTitle == "Okay that's cool")
        XCTAssertTrue(entry1.entryContent == "Very very cool")
        XCTAssertTrue(entry1.longitude == 1.11)
        XCTAssertTrue(entry1.latitude == -2.22)
        XCTAssertTrue(entry1.tags == NSSet(array: [tag1, tag2]))
        XCTAssertTrue(entry1.favorite == true)
    }
    
    func testUpdateJournalEntry() {
        let entry0 = journalEntryService.createJournalEntry()
        XCTAssertNotNil(entry0, "Entry0 should not be nil")
        XCTAssertNil(entry0.image)
        
        let date1 = Date(timeIntervalSince1970: 10080)
        let date2 = Date(timeIntervalSince1970: 10020)
        let tag1 = journalEntryService.createNewTag("Sci-Fi")
        let tag2 = journalEntryService.createNewTag("Starts")
        let image1 = UIImage(named: "TestImage1")
        let image2 = UIImage(named: "TestImage2")
        journalEntryService.updateJournalEntry(entry0,
                                               aboutWork: "Interstellar",
                                               withCoverImage: image1,
                                               withStartDate: date1,
                                               withFinishDate: date2,
                                               withEntryTitle: "Impressive",
                                               withEntryContent: "I don't know what to say",
                                               atLongitude: 3.14,
                                               atLatitude: -6.28,
                                               withTags: [tag1, tag2],
                                               isFavorite: true)
        XCTAssertTrue(entry0.worksTitle == "Interstellar")
        XCTAssertNotNil(entry0.image)
        XCTAssertTrue(entry0.startDate == date1)
        XCTAssertTrue(entry0.finishDate == date2)
        XCTAssertTrue(entry0.entryTitle == "Impressive")
        XCTAssertTrue(entry0.entryContent == "I don't know what to say")
        XCTAssertTrue(entry0.longitude == 3.14)
        XCTAssertTrue(entry0.latitude == -6.28)
        XCTAssertTrue(entry0.tags == NSSet(array: [tag1, tag2]))
        XCTAssertTrue(entry0.favorite == true)
        
        let entry1 = journalEntryService.createJournalEntry(aboutWork: "Batman",
                                                            withCoverImage: image1,
                                                            withStartDate: date1,
                                                            withFinishDate: date2,
                                                            withEntryTitle: "Okay that's cool",
                                                            withEntryContent: "Very very cool",
                                                            atLongitude: 1.11,
                                                            atLatitude: -2.22,
                                                            withTags: [tag1, tag2],
                                                            isFavorite: true)
        XCTAssertNotNil(entry1, "Entry1 should not be nil")
        
        let date3 = Date(timeIntervalSince1970: 20060)
        let tag3 = journalEntryService.createNewTag("NVM")
        journalEntryService.updateJournalEntry(entry1,
                                               aboutWork: "Hitman",
                                               withCoverImage: image2,
                                               withStartDate: date1,
                                               withFinishDate: date3,
                                               withEntryTitle: "Not bad",
                                               withEntryContent: "Just okay",
                                               atLongitude: -6.7,
                                               atLatitude: 239432,
                                               withTags: [tag1, tag3],
                                               isFavorite: false)
        XCTAssertTrue(entry1.worksTitle == "Hitman")
        XCTAssertTrue(entry1.image == image2?.pngData())
        XCTAssertTrue(entry1.startDate == date1)
        XCTAssertTrue(entry1.finishDate == date3)
        XCTAssertTrue(entry1.entryTitle == "Not bad")
        XCTAssertTrue(entry1.entryContent == "Just okay")
        XCTAssertTrue(entry1.longitude == -6.7)
        XCTAssertTrue(entry1.latitude == 239432)
        XCTAssertTrue(entry1.tags == NSSet(array: [tag1, tag3]))
        XCTAssertTrue(entry1.favorite == false)
    }

    func testDeleteJournalEntry() {
        let entry0 = journalEntryService.createJournalEntry()
        XCTAssertNotNil(entry0, "Entry0 should not be nil before deletion")
        
        journalEntryService.deleteJournalEntry(entry0)
        let result0 = journalEntryService.fetchJournalEntries()
        XCTAssertTrue(result0?.count == 0, "There should be no entry after entry0 is deleted")
        
        let date1 = Date(timeIntervalSince1970: 10080)
        let date2 = Date(timeIntervalSince1970: 10080)
        let tag1 = journalEntryService.createNewTag("good")
        let tag2 = journalEntryService.createNewTag("good2")
        let entry1 = journalEntryService.createJournalEntry(aboutWork: "Batman",
                                                            withStartDate: date1,
                                                            withFinishDate: date2,
                                                            withEntryTitle: "Okay that's cool",
                                                            withEntryContent: "Very very cool",
                                                            atLongitude: 1.11,
                                                            atLatitude: -2.22,
                                                            withTags: [tag1, tag2],
                                                            isFavorite: true)
        XCTAssertNotNil(entry1, "Entry1 should not be nil before deletion")
        
        journalEntryService.deleteJournalEntry(entry1)
        let result1 = journalEntryService.fetchJournalEntries()
        XCTAssertTrue(result1?.count == 0, "There should be no entry after entry1 is deleted")
    }
    
    // MARK: - TODO: Tag Test Cases
}
