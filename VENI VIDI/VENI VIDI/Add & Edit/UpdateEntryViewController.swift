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

        title = "Entry Info"
        hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.prefersLargeTitles = true

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
            }
        }

        loadCM(newEntryCM)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
