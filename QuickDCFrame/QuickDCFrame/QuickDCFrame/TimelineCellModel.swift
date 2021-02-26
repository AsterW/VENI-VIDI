//
//  TimelineCellModel.swift
//  QuickDCFrame
//
//  Created by 马晓雯 on 2/21/21.
//

import Foundation
import DCFrame
import UIKit

class TimelineCellModel:DCCellModel{
    var title: String = "some title"
    var picture: UIImage?
    var rating: Double = 0
    
    required init() {
        super.init()
        cellHeight = 100
        cellClass = TimelineCell.self
    }

}
