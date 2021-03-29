//
//  UpdateEntryViewController.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 3/8/21.
//

import Foundation
import DCFrame
import UIKit

class UpdateEnrtyViewController: DCViewController{
    var entryId:UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Update Entry")
        
        let newEntryCM = UpdateEntryContainerModel()
        newEntryCM.nav=navigationController
        
        let dataService=DataService(coreDataStack: CoreDataStack())
        if let id=entryId{
            print("Updating Entry")
            print(id)
            newEntryCM.entryId=id
            if let entry=dataService.fetchJournalEntryWithUUID(id){
                print("yes")
                newEntryCM.entryTitle=entry.worksTitle
                newEntryCM.comment=entry.entryContent
                if let imageData=entry.image{
                    newEntryCM.poster=UIImage(data: imageData)
                }
            }
            
        }
        else{//Create a new entry, load that empty entry and perform update
            print("Creating new entry")
            let newEntry = dataService.createJournalEntry()
            if let id=newEntry.id{
                if let entry=dataService.fetchJournalEntryWithUUID(id){
                    newEntryCM.entryTitle=entry.worksTitle
                    newEntryCM.comment=entry.entryContent
                    if let imageData=entry.image{
                        newEntryCM.poster=UIImage(data: imageData)
                    }
                }
            }
        }
        
        
        loadCM(newEntryCM)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    

}
