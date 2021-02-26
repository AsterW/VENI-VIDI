//
//  TimelineData.swift
//  QuickDCFrame
//
//  Created by 马晓雯 on 2/21/21.
//

import Foundation
import UIKit

class TimelineData{
    var entries: [EntryData]=[]
    var count:Int?
    
    init() {
        count=10
    }
    
    func getEntryData(){
        //fetch user entry data from CloudKit / Firebase
        //for now, fake some data
        for num in 0...9{
            var entry=EntryData()
            //print(num)
            entry.title = " \(num) "
            print(entry.title)
            entry.url="star"
            if(num%2==0){
                entry.date=1
                entry.rate=Double.random(in: 0 ..< 5.0)
            }
            else{
                entry.date=2
                entry.rate=Double.random(in: 0 ..< 5.0)
            }
            entries.append(entry)
        }
        
        entries[0].url="hp"
        entries[1].url="zero"
        entries[2].url="downton"
        entries[3].url="avengers"
        entries[4].url="starwars"
        entries[5].url="coco"
        entries[6].url="1984"
        entries[7].url="soul"
        entries[8].url="3body"
        entries[9].url="art"
    }
    
    func filterDataByMonth(targetMonth: Int)->[EntryData]{
        var filteredEntries:[EntryData]=[]
        for num in 0...count!-1{
            if(entries[num].date==targetMonth){
                filteredEntries.append(entries[num])
            }
        }
        return filteredEntries
    }
    
    func sortByMonth(){
        entries.sort{
            $0.date!>$1.date!
        }
        print(entries)
    }
    
}
