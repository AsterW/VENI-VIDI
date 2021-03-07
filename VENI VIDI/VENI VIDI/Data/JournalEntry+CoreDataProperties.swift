//
//  JournalEntry+CoreDataProperties.swift
//  
//
//  Created by 雲無心 on 3/6/21.
//
//

import Foundation
import CoreData


extension JournalEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalEntry> {
        return NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
    }

    @NSManaged public var startDate: Date?
    @NSManaged public var entryContent: String?
    @NSManaged public var entryTitle: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var lastEditDate: Date?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var worksTitle: String?
    @NSManaged public var finishDate: Date?
    @NSManaged public var tags: NSSet?

}

// MARK: Generated accessors for tags
extension JournalEntry {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}
