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

import UIKit
@testable import VENI_VIDI
import XCTest

class CoreDataTests: XCTestCase {
    // MARK: - Properties and Set Up

    var coreDataStack: CoreDataStack!
    var dataService: DataService!
    var secondDataService: DataService!

    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        dataService = DataService(coreDataStack: coreDataStack)
        secondDataService = DataService(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
    }
    
    // MARK: - Journal Entry Test Cases
    
    func testCreateJournalEntry() {
        let entry0 = dataService.createJournalEntry()
        XCTAssertNotNil(entry0, "entry0 should not be nil")
        XCTAssertNotNil(entry0.id, "entry0.id should not be nil")
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
        let tag1 = dataService.createNewTag("Badass")
        let tag2 = dataService.createNewTag("Superhero")
        let image1 = UIImage(named: "TestImage1")
        XCTAssertNotNil(image1)
        let entry1 = dataService.createJournalEntry(aboutWork: "Batman",
                                                    withCoverImage: image1,
                                                    withStartDate: date1,
                                                    withFinishDate: date2,
                                                    withEntryTitle: "Okay that's cool",
                                                    withEntryContent: "Very very cool",
                                                    atLongitude: 1.11,
                                                    atLatitude: -2.22,
                                                    withTags: [tag1, tag2],
                                                    isFavorite: true)
        XCTAssertNotNil(entry1, "entry1 should not be nil")
        XCTAssertNotNil(entry1.id, "entry1.id should not be nil")
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
        let entry0 = dataService.createJournalEntry()
        XCTAssertNotNil(entry0, "entry0 should not be nil")
        XCTAssertNotNil(entry0.id, "entry0.id should not be nil")
        XCTAssertNil(entry0.image)
        
        let date1 = Date(timeIntervalSince1970: 10080)
        let date2 = Date(timeIntervalSince1970: 10020)
        let tag1 = dataService.createNewTag("Sci-Fi")
        let tag2 = dataService.createNewTag("Starts")
        let image1 = UIImage(named: "TestImage1")
        let image2 = UIImage(named: "TestImage2")
        XCTAssertNotNil(image1)
        XCTAssertNotNil(image2)
        XCTAssertTrue(dataService.updateJournalEntry(withUUID: entry0.id ?? UUID(),
                                                     aboutWork: "Interstellar",
                                                     withCoverImage: image1,
                                                     withStartDate: date1,
                                                     withFinishDate: date2,
                                                     withEntryTitle: "Impressive",
                                                     withEntryContent: "I don't know what to say",
                                                     atLongitude: 3.14,
                                                     atLatitude: -6.28,
                                                     withTags: [tag1, tag2],
                                                     isFavorite: true))
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
        let fetchedEntry0 = dataService.fetchJournalEntryWithUUID(entry0.id!)
        XCTAssertNotNil(fetchedEntry0)
        XCTAssertTrue(fetchedEntry0?.worksTitle == "Interstellar")
        XCTAssertNotNil(fetchedEntry0?.image)
        XCTAssertTrue(fetchedEntry0?.startDate == date1)
        XCTAssertTrue(fetchedEntry0?.finishDate == date2)
        XCTAssertTrue(fetchedEntry0?.entryTitle == "Impressive")
        XCTAssertTrue(fetchedEntry0?.entryContent == "I don't know what to say")
        XCTAssertTrue(fetchedEntry0?.longitude == 3.14)
        XCTAssertTrue(fetchedEntry0?.latitude == -6.28)
        XCTAssertTrue(fetchedEntry0?.tags == NSSet(array: [tag1, tag2]))
        XCTAssertTrue(fetchedEntry0?.favorite == true)
        
        let entry1 = dataService.createJournalEntry(aboutWork: "Batman",
                                                    withCoverImage: image1,
                                                    withStartDate: date1,
                                                    withFinishDate: date2,
                                                    withEntryTitle: "Okay that's cool",
                                                    withEntryContent: "Very very cool",
                                                    atLongitude: 1.11,
                                                    atLatitude: -2.22,
                                                    withTags: [tag1, tag2],
                                                    isFavorite: true)
        XCTAssertNotNil(entry1, "entry1 should not be nil")
        XCTAssertNotNil(entry1.id, "entry1.id should not be nil")
        
        let date3 = Date(timeIntervalSince1970: 20060)
        let tag3 = dataService.createNewTag("NVM")
        XCTAssertTrue(dataService.updateJournalEntry(withUUID: entry1.id ?? UUID(),
                                                     aboutWork: "Hitman",
                                                     withCoverImage: image2,
                                                     withStartDate: date1,
                                                     withFinishDate: date3,
                                                     withEntryTitle: "Not bad",
                                                     withEntryContent: "Just okay",
                                                     atLongitude: -6.7,
                                                     atLatitude: 239432,
                                                     withTags: [tag1, tag3],
                                                     isFavorite: false))
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
        let entry0 = dataService.createJournalEntry()
        XCTAssertNotNil(entry0, "entry0 should not be nil before deletion")
        XCTAssertNotNil(entry0.id, "entry0.id should not be nil before deletion")
        
        XCTAssertTrue(dataService.deleteJournalEntry(withUUID: entry0.id ?? UUID()))
        let result0 = dataService.fetchAllJournalEntries()
        XCTAssertTrue(result0?.count == 0, "There should be no entry after entry0 is deleted")
        
        let date1 = Date(timeIntervalSince1970: 10080)
        let date2 = Date(timeIntervalSince1970: 10080)
        let tag1 = dataService.createNewTag("good")
        let tag2 = dataService.createNewTag("good2")
        let entry1 = dataService.createJournalEntry(aboutWork: "Batman",
                                                    withStartDate: date1,
                                                    withFinishDate: date2,
                                                    withEntryTitle: "Okay that's cool",
                                                    withEntryContent: "Very very cool",
                                                    atLongitude: 1.11,
                                                    atLatitude: -2.22,
                                                    withTags: [tag1, tag2],
                                                    isFavorite: true)
        XCTAssertNotNil(entry1, "entry1 should not be nil before deletion")
        XCTAssertNotNil(entry1.id, "entry1.id should not be nil before deletion")
        
        XCTAssertTrue(dataService.deleteJournalEntry(withUUID: entry1.id ?? UUID()))
        let result1 = dataService.fetchAllJournalEntries()
        XCTAssertTrue(result1?.count == 0, "There should be no entry after entry1 is deleted")
    }
    
    func testFetchJournalEntryWithUUID() {
        let entry0 = dataService.createJournalEntry()
        let fetchedEntry0 = dataService.fetchJournalEntryWithUUID(entry0.id!)
        XCTAssertTrue(entry0 == fetchedEntry0)

        let date1 = Date(timeIntervalSince1970: 10080)
        let date2 = Date(timeIntervalSince1970: 10080)
        let tag1 = dataService.createNewTag("Badass")
        let tag2 = dataService.createNewTag("Superhero")
        let image1 = UIImage(named: "TestImage1")
        let image2 = UIImage(named: "TestImage2")
        XCTAssertNotNil(image1)
        XCTAssertNotNil(image2)
        let entry1 = dataService.createJournalEntry(aboutWork: "Batman",
                                                    withCoverImage: image1,
                                                    withStartDate: date1,
                                                    withFinishDate: date2,
                                                    withEntryTitle: "Okay that's cool",
                                                    withEntryContent: "Very very cool",
                                                    atLongitude: 1.11,
                                                    atLatitude: -2.22,
                                                    withTags: [tag1, tag2],
                                                    isFavorite: true)
        XCTAssertNotNil(entry1, "entry1 should not be nil")
        XCTAssertNotNil(entry1.id, "entry1.id should not be nil")
        let date3 = Date(timeIntervalSince1970: 20060)
        let tag3 = dataService.createNewTag("NVM")
        XCTAssertTrue(dataService.updateJournalEntry(withUUID: entry1.id ?? UUID(),
                                                     aboutWork: "Hitman",
                                                     withCoverImage: image2,
                                                     withStartDate: date1,
                                                     withFinishDate: date3,
                                                     withEntryTitle: "Not bad",
                                                     withEntryContent: "Just okay",
                                                     atLongitude: -6.7,
                                                     atLatitude: 239432,
                                                     withTags: [tag1, tag3],
                                                     isFavorite: false))
        let fetchedEntry1 = dataService.fetchJournalEntryWithUUID(entry1.id!)
        XCTAssertTrue(entry1 == fetchedEntry1)
    }
    
    func testCrossDataServiceAccess() {
        XCTAssertFalse(dataService === secondDataService)
        
        let entry0 = dataService.createJournalEntry()
        XCTAssertNotNil(entry0)
        XCTAssertTrue(secondDataService.fetchAllJournalEntries()?.count == 1)
        
        let date1 = Date(timeIntervalSince1970: 10080)
        let date2 = Date(timeIntervalSince1970: 10080)
        let tag1 = dataService.createNewTag("good")
        let tag2 = secondDataService.createNewTag("good2")
        let entry1 = secondDataService.createJournalEntry(aboutWork: "Batman",
                                                          withStartDate: date1,
                                                          withFinishDate: date2,
                                                          withEntryTitle: "Okay that's cool",
                                                          withEntryContent: "Very very cool",
                                                          atLongitude: 1.11,
                                                          atLatitude: -2.22,
                                                          withTags: [tag1, tag2],
                                                          isFavorite: true)
        XCTAssertNotNil(entry1)
        XCTAssertTrue(dataService.fetchAllJournalEntries()?.count == 2)
    }
    
    // MARK: - TODO: Tag Test Cases
}