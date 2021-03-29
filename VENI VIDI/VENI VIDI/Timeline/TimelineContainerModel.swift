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
//    var timeLineData:TimelineData?
    var entries:[JournalEntry]?
//    var entryService:JournalEntryService?
    var currentTimeLabel:DateComponents?
    
    func getEntryData(){
        if let entries=dataService.fetchAllJournalEntries(){
            print(entries.count)
            self.entries=entries

        }
    }
    
    override func tableViewDataWillReload() {
        print("CM Reloading")
        currentTimeLabel=Calendar.current.dateComponents([.day, .year, .month], from: Date())
        
        removeAllSubmodels()
        
        getEntryData()

//        let timeModel=TimeLabelCellModel()
//        timeModel.timeLabel="March"
//        addSubmodel(timeModel)
        if let dateComponents=currentTimeLabel{
            createTimeLabel(date: dateComponents)
        }
        
        if let e=entries{
            for item in e {
                let calanderDate = Calendar.current.dateComponents([.day, .year, .month], from: item.finishDate!)
                guard let timeLabel = currentTimeLabel else { return }
                if (calanderDate.year != timeLabel.year || calanderDate.month != timeLabel.month){
                    currentTimeLabel=calanderDate
                    print("Calendar Date is \(calanderDate)")
                    createTimeLabel(date: calanderDate)
                }
//                print("Calendar Date is \(calanderDate)")
//                createTimeLabel(date: calanderDate)

                let model = TimelineCellModel()
                if let id=item.id{
                    model.entryId=id
                }
                model.title = item.entryTitle ?? "No Title"
                if let imageData=item.image{
                    print(imageData)
                    model.picture=UIImage(data: imageData)
                }
                else{
                    model.picture = UIImage(systemName: "star.fill")
                }
                model.rating=Double.random(in: 0 ..< 5.0)
                addSubmodel(model, separator: .bottom, height: 2)
            }
        }
    }
    
    func createTimeLabel(date:DateComponents){
        let timeModel=TimeLabelCellModel()
        switch date.month{
            case 1:
                timeModel.timeLabel="\(date.year ?? 1970)  January"
            case 2:
                timeModel.timeLabel="\(date.year ?? 1970)  February"
            case 3:
                timeModel.timeLabel="\(date.year ?? 1970)  March"
            case 4:
                timeModel.timeLabel="\(date.year ?? 1970)  April"
            case 5:
                timeModel.timeLabel="\(date.year ?? 1970)  May"
            case 6:
                timeModel.timeLabel="\(date.year ?? 1970)  June"
            case 7:
                timeModel.timeLabel="\(date.year ?? 1970)  July"
            case 8:
                timeModel.timeLabel="\(date.year ?? 1970)  August"
            case 9:
                timeModel.timeLabel="\(date.year ?? 1970)  September"
            case 10:
                timeModel.timeLabel="\(date.year ?? 1970)  Octuber"
            case 11:
                timeModel.timeLabel="\(date.year ?? 1970)  November"
            case 12:
                timeModel.timeLabel="\(date.year ?? 1970)  December"
            case .none:
                timeModel.timeLabel=""
            case .some(_):
                timeModel.timeLabel=""
        }
        addSubmodel(timeModel)
    }
    
    override func cmDidLoad() {
        super.cmDidLoad()
        
        print("load Timeline")
        containerTableView?.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        getEntryData()
//create an entry in Feb
//        var date=DateComponents()
//        date.day=20
//        date.month=2
//        date.year=2021
//        let userCalendar = Calendar(identifier: .gregorian) // since the components above (like year 1980) are for Gregorian
//        let someDateTime = userCalendar.date(from: date)
//        dataService.createJournalEntry(aboutWork: "February Movie", withStartDate: someDateTime!, withFinishDate: someDateTime!, withEntryTitle: "February Movie", withEntryContent: "Some comment", isFavorite: false)
        
        
//        let timeModel=TimeLabelCellModel()
//        timeModel.timeLabel="March"
//        addSubmodel(timeModel)
        
        if let e=entries{
            for item in e {

                let model = TimelineCellModel()
                if let id=item.id{
                    model.entryId=id
                }
                model.title = item.entryTitle ?? "No Title"
                if let imageData=item.image{
                    print(imageData)
                    model.picture=UIImage(data: imageData)
                }
                else{
                    model.picture = UIImage(systemName: "star.fill")
                }
                model.rating=Double.random(in: 0 ..< 5.0)
                addSubmodel(model)
            }
        }
    }
    
}

