//
//  TagCellModel.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 4/18/21.
//

import Foundation
import UIKit
import DCFrame
class TagCellModel:DCCellModel{
    required init() {
        super.init()
        cellHeight = 830
        cellClass = TagCell.self
    }
}