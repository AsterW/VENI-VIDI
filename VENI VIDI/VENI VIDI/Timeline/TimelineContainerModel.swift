//
//  TimelineContainerModek.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import Foundation
import UIKit
import DCFrame

class SimpleListContainerModel: VVContainerModel {
    var timeLineData:TimelineData?
    var entries:[JournalEntry]?
//    var entryService:JournalEntryService?
    
    func getEntryData(){
        if let entries=dataService.fetchAllJournalEntries(){
            print(entries.count)
            self.entries=entries
            let entryOne=entries[0]
            print(entryOne.entryTitle ?? "No Title")
        }
    }
    
    override func cmDidLoad() {
        super.cmDidLoad()
        let date1=Date()
        let date2=Date().addingTimeInterval(86400)
        print(date2.description)
        
        
        
        _ = dataService.createJournalEntry(aboutWork: "Avengers", withStartDate: date1, withFinishDate: date1, withEntryTitle: "Avengers", isFavorite: true)
        _ = dataService.createJournalEntry(aboutWork: "Stars", withStartDate: date2, withFinishDate: date2, withEntryTitle: "Stars", isFavorite: true)
        
        _ = dataService.createJournalEntry(aboutWork: "Coco", withStartDate: date1, withFinishDate: date1, withEntryTitle: "Coco", isFavorite: true)
        _ = dataService.createJournalEntry(aboutWork: "Harry Potter", withStartDate: date2, withFinishDate: date2, withEntryTitle: "Harry Potter", isFavorite: true)
        _ = dataService.createJournalEntry(aboutWork: "Spiderman", withStartDate: date1, withFinishDate: date1, withEntryTitle: "Spiderman", isFavorite: true)
        _ = dataService.createJournalEntry(aboutWork: "Aha", withStartDate: date2, withFinishDate: date2, withEntryTitle: "Aha", isFavorite: false)
        
        getEntryData()
        
//        if let handler = entryService{
//            if let entries = handler.fetchJournalEntries(){
//                for item in entries{
//                    print(item.entryTitle ?? "No Title")
//                }
//            }
//        }
        
        timeLineData=TimelineData()
        timeLineData!.getEntryData()
        
        timeLineData!.sortByMonth()
        
        //let filteredOne = timeLineData?.filterDataByMonth(targetMonth: 2)
        //let filteredTwo = timeLineData?.filterDataByMonth(targetMonth: 1)
        
        
        let timeModel=TimeLabelCellModel()
        timeModel.timeLabel="March"
        addSubmodel(timeModel)
        
        if let e=entries{
            for item in e {
                let model = TimelineCellModel()
                model.title = item.entryTitle ?? "No Title"
                model.picture = UIImage(systemName: "star.fill")
                model.rating=Double.random(in: 0 ..< 5.0)
                addSubmodel(model)
            }
        }
        
        
        
        
//        for num in 1...filteredOne!.count-1{
//            let model = TimelineCellModel()
//            model.title = filteredOne![num].title
//            model.picture = UIImage(named: filteredOne![num].url)
//            model.rating = filteredOne![num].rate!
//            addSubmodel(model)
//        }
//
        let timeModel2=TimeLabelCellModel()
        timeModel2.timeLabel="February"
        addSubmodel(timeModel2)
        
//
//        for num in 0...filteredTwo!.count-1{
//
//            let model = TimelineCellModel()
//            model.title = filteredTwo![num].title
//            model.picture = UIImage(named: filteredTwo![num].url)
//            model.rating = filteredTwo![num].rate!
//            addSubmodel(model)
//        }
    }
    
}

