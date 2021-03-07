//
//  TestController.swift
//  VENI VIDI
//
//  Created by 雲無心 on 2/28/21.
//

import UIKit
import CoreData

class EntryDataHandler: NSObject {

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
    
    func createNewTag(_ tagText: String) -> Tag? {
        let newTag = Tag(context: self.context)
        newTag.text = tagText
        do {
            try self.context.save()
            return newTag
        }
        catch {
            print("Unexpected error at createNewTag(): \(error)")
            return nil
        }
    }
    
    func fetchAllTags() -> [Tag] {
        do {
            let fetchRequest = Tag.fetchRequest() as NSFetchRequest<Tag>
            let tags = try context.fetch(fetchRequest)
            return tags
        } catch {
            print("Unexpected error at fetchAllTags(): \(error)")
            return []
        }
    }
    
    func fetchJournalEntries() -> [JournalEntry]? {
        do {
            let fetchRequest = JournalEntry.fetchRequest() as NSFetchRequest<JournalEntry>
            let entries = try context.fetch(fetchRequest)
            if entries.isEmpty {
                return nil
            }
            return entries
        } catch {
            print("Unexpected error at fetchJournalEntries(): \(error)")
            return nil
        }
    }
    
    func createJournalEntry(aboutWork work: String? = nil,
                            withStartDate startDate: Date? = nil,
                            withFinishDate finishDate: Date? = nil,
                            withEntryTitle entryTitle: String? = nil,
                            withEntryContent entryContent: String? = nil,
                            atLongitude longitude: Double? = nil,
                            atLatitude latitude: Double? = nil,
                            withTags tags: [Tag]? = nil,
                            isFavorite favorite: Bool? = nil) -> JournalEntry? {
        
        let newJournalEntry = JournalEntry(context: self.context)
        newJournalEntry.startDate = Date()
        newJournalEntry.finishDate = Date()
        
        do {
            try self.context.save()
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
        catch {
            print("Unexpected error at createJournalEntry(): \(error)")
            return nil
        }
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
                            isFavorite favorite: Bool? = nil) {
        
        entry.lastEditDate = Date()
        
        if let newWorksTitle = work {
            entry.worksTitle = newWorksTitle
        }
        
        if let newStartDate = startDate {
            entry.startDate = newStartDate
        }
        
        if let newFinishDate = finishDate {
            entry.finishDate = newFinishDate
        }
        
        if let newEntryTitle = entryTitle {
            entry.entryTitle = newEntryTitle
        }
        
        if let newEntryContent = entryContent {
            entry.entryContent = newEntryContent
        }
        
        if let newLongitude = longitude {
            if let newLatitude = latitude {
                entry.longitude = newLongitude
                entry.latitude = newLatitude
            }
            print("Entry location not updated. Both longitude and latitude needed for update.")
        }
        
        if let newFavorite = favorite {
            entry.favorite = newFavorite
        }
        
        if let newTags = tags {
            for tag in entry.tags ?? [] {
                if let tagToCheck = (tag as? Tag) {
                    if !newTags.contains(tagToCheck) {
                        entry.removeFromTags(tagToCheck)
                    }
                }
            }
            
            entry.addToTags(NSSet(array: newTags))
        }
        
        do {
            try self.context.save()
        }
        catch {
            print("Unexpected error at updateJournalEntry(): \(error)")
        }
    }
    
    func deleteJournalEntry(_ entry: JournalEntry) {
        self.context.delete(entry)
    }
}

