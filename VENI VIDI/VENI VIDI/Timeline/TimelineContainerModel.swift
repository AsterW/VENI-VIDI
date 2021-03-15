//
//  TimelineContainerModek.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import Foundation
import UIKit
import DCFrame

class SimpleListContainerModel: DCContainerModel {
    var timeLineData:TimelineData?
    var entryService:JournalEntryService?
    
    override func cmDidLoad() {
        super.cmDidLoad()
        
        if let handler = entryService{
            if let entries = handler.fetchJournalEntries(){
                for item in entries{
                    print(item.entryTitle ?? "No Title")
                }
            }

        }
        
        timeLineData=TimelineData()
        timeLineData!.getEntryData()
        
        timeLineData!.sortByMonth()
        
        let filteredOne = timeLineData?.filterDataByMonth(targetMonth: 2)
        let filteredTwo = timeLineData?.filterDataByMonth(targetMonth: 1)
        
        
        let timeModel=TimeLabelCellModel()
        timeModel.timeLabel="February"
        addSubmodel(timeModel)
        
        for num in 0...filteredOne!.count-1{
            let model = TimelineCellModel()
            model.title = filteredOne![num].title
            model.picture = UIImage(named: filteredOne![num].url)
            model.rating = filteredOne![num].rate!
            addSubmodel(model)
        }
        
        let timeModel2=TimeLabelCellModel()
        timeModel2.timeLabel="January"
        addSubmodel(timeModel2)
        
        for num in 0...filteredTwo!.count-1{
            
            let model = TimelineCellModel()
            model.title = filteredTwo![num].title
            model.picture = UIImage(named: filteredTwo![num].url)
            model.rating = filteredTwo![num].rate!
            addSubmodel(model)
        }
        
        /*
        for num in 0...timeLineData!.count! {
            let model = TimelineCellModel()
            model.title = timeLineData!.entries[num].title
            model.picture = UIImage(systemName: timeLineData!.entries[num].url)
            addSubmodel(model)
        }
 */
    }
}

