//
//  TagTests.swift
//  VENI VIDITests
//
//  Created by 雲無心 on 4/28/21.
//

@testable import VENI_VIDI
import UIKit
import XCTest

extension DataServiceTests {
    // MARK: - Tag Test Cases

    func testCreateNewTag() {
        let tag = dataService.createNewTag("a tag")

        XCTAssertEqual(tag.name, "a tag")
        XCTAssertNotNil(tag.id)
    }

    func testRenameTag() {
        let tag = dataService.createNewTag("a tag")
        // swiftlint:disable:next identifier_name
        guard let id = tag.id else { XCTFail("Tag.id should not be nil"); return }
        let renamedTag = dataService.renameTagWithUUID(id, withNewName: "a new name")

        XCTAssertEqual(tag.id, renamedTag?.id)
        XCTAssertEqual(tag.name, "a new name")
        XCTAssertEqual(renamedTag?.name, "a new name")
    }

    func testDeleteTag() {
        let tag = dataService.createNewTag("a tag")
        // swiftlint:disable:next identifier_name
        guard let id = tag.id else { XCTFail("Tag.id should not be nil"); return }
        XCTAssertTrue(dataService.deleteTagWithUUID(id))

        XCTAssertTrue(dataService.fetchAllTags().isEmpty)
    }

    func testFetchAllTags() {
        let tag1 = dataService.createNewTag("a tag")
        let tag2 = dataService.createNewTag("another tag")
        let tag3 = dataService.createNewTag("one more tag")

        let fetchedTags = dataService.fetchAllTags()
        XCTAssertEqual(fetchedTags.count, 3)

        var fetchedTagUUIDs = Set<UUID>()
        for tag in fetchedTags {
            // swiftlint:disable:next identifier_name
            guard let id = tag.id else { XCTFail("Tag.id should not be nil"); return }
            fetchedTagUUIDs.insert(id)
        }

        guard let id1 = tag1.id else { XCTFail("Tag.id should not be nil"); return }
        guard let id2 = tag2.id else { XCTFail("Tag.id should not be nil"); return }
        guard let id3 = tag3.id else { XCTFail("Tag.id should not be nil"); return }

        XCTAssertTrue(fetchedTagUUIDs.contains(id1))
        XCTAssertTrue(fetchedTagUUIDs.contains(id2))
        XCTAssertTrue(fetchedTagUUIDs.contains(id3))

        var fetchedTagNames = Set<String>()
        for tag in fetchedTags {
            guard let name = tag.name else { XCTFail("tag.name should not be nil"); return }
            fetchedTagNames.insert(name)
        }
        XCTAssertTrue(fetchedTagNames.contains("a tag"))
        XCTAssertTrue(fetchedTagNames.contains("another tag"))
        XCTAssertTrue(fetchedTagNames.contains("one more tag"))
    }
}
