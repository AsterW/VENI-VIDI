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
        if let id = entryId {
            print("Updating Entry")
            print(id)
            newEntryCM.entryId = id
            if let entry = dataService.fetchJournalEntryWithUUID(id) {
                print("yes")
                newEntryCM.entryTitle = entry.worksTitle
                newEntryCM.comment = entry.entryContent
                if let imageData = entry.image {
                    newEntryCM.poster = UIImage(data: imageData)
                }
            }
        }

        loadCM(newEntryCM)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
