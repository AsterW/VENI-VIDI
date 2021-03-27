//
//  TimelineViewController.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import Foundation
import DCFrame
import UIKit

class TimelineViewController: DCViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Try to add some data
//        _ = journalEntryService.createJournalEntry(aboutWork: "Avengers", withStartDate: Date(), withFinishDate: Date(), withEntryTitle: "Avengers", isFavorite: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd))
        navigationController?.navigationBar.barTintColor = UIColor.systemBackground
        
        EDC.subscribeEvent(TimelineCell.touch, target: self) {[weak self] (data:EntryData) in
            print("pushing View Controller")
            guard let `self` = self else {
                return
            }
            let vc = DetailedEntryViewController()
            vc.entryData.title = data.title
            vc.entryData.comment = data.comment
            vc.entryData.rate = data.rate
            vc.entryData.url = data.url
            vc.entryData.date=data.date
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let simpleListCM = SimpleListContainerModel()
        loadCM(simpleListCM)
        
        //get the entries from Core Data
//        if let entries=journalEntryService.fetchJournalEntries(){
//            let entryOne=entries[0]
//        }

    }
    
    @objc func onAdd(){
        let vc = UpdateEnrtyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

}
