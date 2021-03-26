//
//  EntryService.swift
//  VENI VIDI
//
//  Created by 雲無心 on 3/13/21.
//

import CoreData
import Foundation

final class JournalEntryService {
    // MARK: - Properties

    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    // MARK: - Initializers

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = self.coreDataStack.mainContext
    }
}

// MARK: - Tag Handling

extension JournalEntryService {
    func fetchAllTags() -> [Tag] {
        do {
            let fetchRequest = NSFetchRequest<Tag>(entityName: "Tag")
            let tags = try managedObjectContext.fetch(fetchRequest)
            return tags
        } catch {
            print("Unexpected error at fetchAllTags(): \(error)")
            return []
        }
    }
    
    func addTag(_ tag: Tag, toJournalEntry journalEntry: JournalEntry) {
        journalEntry.addToTags(tag)
    }
    
    func addTags(_ tags: [Tag], toJournalEntry journalEntry: JournalEntry) {
        journalEntry.addToTags(NSSet(array: tags))
    }
    
    func removeTag(_ tag: Tag, fromJournalEntry journalEntry: JournalEntry) {
        journalEntry.removeFromTags(tag)
    }
    
    func removeTags(_ tags: [Tag], fromJournalEntry journalEntry: JournalEntry) {
        journalEntry.removeFromTags(NSSet(array: tags))
    }
    
    func createNewTag(_ tagText: String) -> Tag {
        let newTag = NSEntityDescription.insertNewObject(forEntityName: "Tag", into: self.managedObjectContext) as! Tag
//        let newTag = Tag(context: self.managedObjectContext)
        newTag.name = tagText
        self.coreDataStack.saveContext()
        return newTag
    }
}

// MARK: - Journal Entry Handling

extension JournalEntryService {
    func fetchJournalEntries() -> [JournalEntry]? {
        do {
            let fetchRequest = NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
            let entries = try managedObjectContext.fetch(fetchRequest)
            return entries
        } catch {
            print("Unexpected error at fetchJournalEntries(): \(error)")
            return nil
        }
    }
    
    func createJournalEntry(aboutWork work: String = "",
                            withStartDate startDate: Date = Date(),
                            withFinishDate finishDate: Date = Date(),
                            withEntryTitle entryTitle: String = "",
                            withEntryContent entryContent: String = "",
                            atLongitude longitude: Double = 0,
                            atLatitude latitude: Double = 0,
                            withTags tags: [Tag]? = [],
                            isFavorite favorite: Bool? = false) -> JournalEntry
    {
        let newJournalEntry = NSEntityDescription.insertNewObject(forEntityName: "JournalEntry", into: self.managedObjectContext) as! JournalEntry
//        let newJournalEntry = JournalEntry(context: self.managedObjectContext)
        
        self.coreDataStack.saveContext()
        self.updateJournalEntry(newJournalEntry,
                                aboutWork: work,
                                withStartDate: startDate,
                                withFinishDate: finishDate,
                                withEntryTitle: entryTitle,
                                withEntryContent: entryContent,
                                atLongitude: longitude,
                                atLatitude: latitude,
                                withTags: tags,
                                isFavorite: favorite)
        return newJournalEntry
    }
    
    func updateJournalEntry(_ entry: JournalEntry,
                            aboutWork work: String? = nil,
                            withStartDate startDate: Date? = nil,
                            withFinishDate finishDate: Date? = nil,
                            withEntryTitle entryTitle: String? = nil,
                            withEntryContent entryContent: String? = nil,
                            atLongitude longitude: Double? = nil,
                            atLatitude latitude: Double? = nil,
                            withTags tags: [Tag]? = nil,
                            isFavorite favorite: Bool? = nil)
    {
        entry.lastEditDate = Date()
        entry.worksTitle = work ?? entry.worksTitle
        entry.startDate = startDate ?? entry.startDate
        entry.finishDate = finishDate ?? entry.finishDate
        entry.entryTitle = entryTitle ?? entry.entryTitle
        entry.entryContent = entryContent ?? entry.entryContent
        entry.favorite = favorite ?? entry.favorite
        
        if let newLongitude = longitude {
            if let newLatitude = latitude {
                entry.longitude = newLongitude
                entry.latitude = newLatitude
            } else {
                print("Entry location not updated. Both longitude and latitude needed for update.")
            }
        }
        
        if let newTags = tags {
//            for tag in entry.tags ?? [] {
//                if let tagToCheck = (tag as? Tag) {
//                    if !newTags.contains(tagToCheck) {
//                        entry.removeFromTags(tagToCheck)
//                    }
//                }
//            }
            let oldTags = entry.tags
            entry.removeFromTags(oldTags ?? NSSet())
            entry.addToTags(NSSet(array: newTags))
        }
        
        self.coreDataStack.saveContext()
    }
    
    func deleteJournalEntry(_ entry: JournalEntry) {
        self.managedObjectContext.delete(entry)
        self.coreDataStack.saveContext()
    }
}
