//
//  UpdateEntryContainerModel.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 3/8/21.
//

import Foundation
import DCFrame
import UIKit

class UpdateEntryContainerModel: VVContainerModel{
    var entryTitle:String?//should be passed by last TimelineViewController
    var poster:UIImage?
    var comment:String?
    var stars:Double?
    var date: Date?
    var nav:UINavigationController?
    
    override func cmDidLoad() {
        super.cmDidLoad()
        
        let newEntryModel=UpdateEntryCellModel()
        newEntryModel.nav=self.nav
        newEntryModel.service=journalEntryService
        _ = journalEntryService.createJournalEntry(aboutWork: "Star", withStartDate: Date(), withFinishDate: Date(), withEntryTitle: "Star", isFavorite: false)
        
        if let entries=journalEntryService.fetchJournalEntries(){
            print(entries.count)
            let entryOne=entries[0]
            print(entryOne.entryTitle ?? "No Title")
        }
        addSubmodel(newEntryModel)

    }
}
