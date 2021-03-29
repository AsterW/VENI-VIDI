//
//  TimeLabelCellModel.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import Foundation
import DCFrame
import UIKit

class TimeLabelCellModel:DCCellModel{
    var timeLabel:String = ""
    
    required init() {
        super.init()
        cellHeight = 60
        cellClass = TimeLabelCell.self
    }

}

