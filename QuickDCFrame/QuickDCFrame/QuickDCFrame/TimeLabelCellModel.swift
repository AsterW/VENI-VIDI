//
//  TimeLabelCellModel.swift
//  QuickDCFrame
//
//  Created by 马晓雯 on 2/21/21.
//

import Foundation
import DCFrame
import UIKit

class TimeLabelCellModel:DCCellModel{
    var timeLabel:String = ""
    
    required init() {
        super.init()
        cellHeight = 30
        cellClass = TimeLabelCell.self
    }

}
