//
//  EntryService.swift
//  VENI VIDI
//
//  Created by 雲無心 on 3/13/21.
//

import CoreData
import Foundation
import UIKit

// MARK: - DataService

final class DataService: NSObject, NSFetchedResultsControllerDelegate {
    // MARK: - Properties

    private let managedObjectContext: NSManagedObjectContext
    private let coreDataStack: CoreDataStack
    private var fetchedResultsController: NSFetchedResultsController<JournalEntry>?
    weak var delegate: DataServiceDelegate?

    // MARK: - Initializers

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        managedObjectContext = self.coreDataStack.mainContext
    }
}

// MARK: - Tag Related Services

extension DataService {
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
        // swiftlint:disable:next line_length
        let newTag = NSEntityDescription.insertNewObject(forEntityName: "Tag", into: managedObjectContext) as! Tag // swiftlint:disable:this force_cast
        // Solution from https://stackoverflow.com/questions/60228931/no-nsentitydescriptions-in-any-model-claim-the-nsmanagedobject-subclass-priorit // swiftlint:disable:this line_length
        // let newTag = Tag(context: self.managedObjectContext)
        newTag.name = tagText
        coreDataStack.saveContext()
        return newTag
    }
}

// MARK: - Journal Entry Services

extension DataService {
    func fetchAllJournalEntries() -> [JournalEntry]? {
        let fetchRequest = NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "finishDate", ascending: false)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: managedObjectContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController?.delegate = self
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
        return fetchedResultsController?.fetchedObjects
    }

    // swiftlint:disable:next identifier_name
    func fetchJournalEntryWithUUID(_ id: UUID) -> JournalEntry? {
        do {
            let fetchRequest = NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            let entry = try managedObjectContext.fetch(fetchRequest)[0]
            return entry
        } catch {
            print("Unexpected error at fetchJournalEntries(): \(error)")
            return nil
        }
    }

    func createJournalEntry(aboutWork work: String = "",
                            withType type: JournalEntryType = .none,
                            withCoverImage coverImage: UIImage? = nil,
                            withStartDate startDate: Date = Date(),
                            withFinishDate finishDate: Date = Date(),
                            withEntryTitle entryTitle: String = "",
                            withEntryContent entryContent: String = "",
                            withQuote quote: String = "",
                            atLongitude longitude: Double = 0,
                            atLatitude latitude: Double = 0,
                            withTags tags: [Tag] = [],
                            withRating rating: Int = 0,
                            isFavorite favorite: Bool? = false) -> JournalEntry {
        // let newJournalEntry = JournalEntry(context: self.managedObjectContext)
        // swiftlint:disable:next line_length
        let newJournalEntry = NSEntityDescription.insertNewObject(forEntityName: "JournalEntry", into: managedObjectContext) as! JournalEntry // swiftlint:disable:this force_cast
        // Solution from https://stackoverflow.com/questions/60228931/no-nsentitydescriptions-in-any-model-claim-the-nsmanagedobject-subclass-priorit // swiftlint:disable:this line_length

        newJournalEntry.id = UUID()
        coreDataStack.saveContext()

        guard updateJournalEntry(withUUID: newJournalEntry.id ?? UUID(),
                                 aboutWork: work,
                                 withType: type,
                                 withCoverImage: coverImage,
                                 withStartDate: startDate,
                                 withFinishDate: finishDate,
                                 withEntryTitle: entryTitle,
                                 withEntryContent: entryContent,
                                 withQuote: quote,
                                 atLongitude: longitude,
                                 atLatitude: latitude,
                                 withTags: tags,
                                 withRating: rating,
                                 isFavorite: favorite)
        else {
            print("JournalEntry Created might not be valid: failed to save designated entry contents")
            return newJournalEntry
        }

        return newJournalEntry
    }

    // swiftlint:disable:next identifier_name
    func updateJournalEntry(withUUID id: UUID,
                            aboutWork work: String? = nil,
                            withType type: JournalEntryType? = nil,
                            withCoverImage coverImage: UIImage? = nil,
                            withStartDate startDate: Date? = nil,
                            withFinishDate finishDate: Date? = nil,
                            withEntryTitle entryTitle: String? = nil,
                            withEntryContent entryContent: String? = nil,
                            withQuote quote: String? = nil,
                            atLongitude longitude: Double? = nil,
                            atLatitude latitude: Double? = nil,
                            withTags tags: [Tag]? = nil,
                            withRating rating: Int? = nil,
                            isFavorite favorite: Bool? = nil) -> Bool {
        guard let entry = fetchJournalEntryWithUUID(id) else {
            print("Received invalid UUID for updateJournalEntry()")
            return false
        }

        entry.lastEditDate = Date()
        entry.worksTitle = work ?? entry.worksTitle
        entry.journalType = type ?? entry.journalType
        entry.startDate = startDate ?? entry.startDate
        entry.finishDate = finishDate ?? entry.finishDate
        entry.entryTitle = entryTitle ?? entry.entryTitle
        entry.entryContent = entryContent ?? entry.entryContent
        entry.quote = quote ?? entry.quote
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
            let oldTags = entry.tags
            entry.removeFromTags(oldTags ?? NSSet())
            entry.addToTags(NSSet(array: newTags))
        }

        if let newImage = coverImage {
            // https://stackoverflow.com/questions/16685812/how-to-store-an-image-in-core-data#16687218
            if let imageData = newImage.pngData() {
                entry.image = imageData
            } else {
                print("Failed to store image in CoreData")
            }
        }

        if let newRating = rating {
            if newRating >= 0, newRating <= 5 {
                entry.rating = Int16(newRating)
            } else {
                print("Received invalid rating value \(newRating)")
            }
        }

        coreDataStack.saveContext()
        return true
    }

    // swiftlint:disable:next identifier_name
    func deleteJournalEntry(withUUID id: UUID) -> Bool {
        guard let entry = fetchJournalEntryWithUUID(id) else {
            print("Received invalid UUID for deleteJournalEntry()")
            return false
        }

        managedObjectContext.delete(entry)
        coreDataStack.saveContext()
        return true
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension DataService {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let updatedJournalEntries = controller.fetchedObjects as? [JournalEntry] {
            print("DataService delegate call with argument \(updatedJournalEntries)")
            delegate?.fetchAllJournalEntriesResultDidChange(updatedJournalEntries)
        } else {
            print("Error: NSFetchedResultsController has a NSFetchRequestResult type different from JournalEntry.") // DEBUG
            // swiftlint:disable:previous line_length
        }
    }
}
