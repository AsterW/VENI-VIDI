//
//  UpdateEntryCellModel.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 3/9/21.
//

import Foundation
import DCFrame
import UIKit

class UpdateEntryCellModel:DCCellModel{
    var entryTitle:String = ""
    var comment:String = ""
    var rating:Double?
    var posterImage: UIImage?
    var date: Date?
    var nav:UINavigationController?
    var service:JournalEntryService={
        let service=JournalEntryService(coreDataStack: CoreDataStack())
        return service
    }()
    
    required init() {
        super.init()
        cellHeight = 800
        cellClass = UpdateEntryCell.self
    }

}