//
//  UpdateEntryViewController.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 3/8/21.
//

import DCFrame
import Foundation
import UIKit

class UpdateEnrtyViewController: DCViewController {
    var entryId: UUID?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Update Entry")
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Entry Info"

        let newEntryCM = UpdateEntryContainerModel()
        newEntryCM.nav = navigationController

        let dataService = DataService(coreDataStack: CoreDataStack())
        // swiftlint:disable:next identifier_name
        if let id = entryId {
            print("Updating Entry")
            print(id)
            newEntryCM.entryId = id
            if let entry = dataService.fetchJournalEntryWithUUID(id) {
                print("yes")
                newEntryCM.entryTitle = entry.worksTitle
                newEntryCM.comment = entry.entryContent
                newEntryCM.quote = entry.quote
                if let imageData = entry.image {
                    newEntryCM.poster = UIImage(data: imageData)
                }
                newEntryCM.stars = Double(entry.rating)
                newEntryCM.favorite = entry.favorite
                newEntryCM.type = entry.journalType

                if let array = entry.tags?.allObjects as? [Tag] {
                    var tags: [String] = []
                    for tag in array {
                        if let string = tag.name {
                            print(string)
                            tags.append(string)
                        }
                    }
                    newEntryCM.tags = tags
                }
            }
        }
//        else{//Create a new entry, load that empty entry and perform update
//            print("Creating new entry")
//            let newEntry = dataService.createJournalEntry()
//            if let id=newEntry.id{
//                newEntryCM.entryId=id
//                if let entry=dataService.fetchJournalEntryWithUUID(id){
//                    newEntryCM.entryTitle=entry.worksTitle
//                    newEntryCM.comment=entry.entryContent
//                    if let imageData=entry.image{
//                        newEntryCM.poster=UIImage(data: imageData)
//                    }
//                }
//            }
//        }

        loadCM(newEntryCM)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
