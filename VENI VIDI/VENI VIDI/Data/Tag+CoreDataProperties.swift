//
//  Tag+CoreDataProperties.swift
//  
//
//  Created by 雲無心 on 3/6/21.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var text: String?
    @NSManaged public var entries: NSSet?

}

// MARK: Generated accessors for entries
extension Tag {

    @objc(addEntriesObject:)
    @NSManaged public func addToEntries(_ value: JournalEntry)

    @objc(removeEntriesObject:)
    @NSManaged public func removeFromEntries(_ value: JournalEntry)

    @objc(addEntries:)
    @NSManaged public func addToEntries(_ values: NSSet)

    @objc(removeEntries:)
    @NSManaged public func removeFromEntries(_ values: NSSet)

}
