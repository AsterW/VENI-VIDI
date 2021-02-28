//
//  DetailedEntryCellModel.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import Foundation
import DCFrame
import UIKit

class DetailedEntryCellModel:DCCellModel{
    var entryTitle:String = ""
    var comment:String = ""
    var rating:Double?
    var posterImage: UIImage?
    
    required init() {
        super.init()
        cellHeight = 800
        cellClass = DetailedEntryCell.self
    }

}
