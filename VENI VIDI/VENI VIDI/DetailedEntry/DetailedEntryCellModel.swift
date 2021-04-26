//
//  DetailedEntryCellModel.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import DCFrame
import Foundation
import UIKit

class DetailedEntryCellModel: DCCellModel {
    var entryTitle: String = ""
    var comment: String = ""
    var rating: Double?
    var posterImage: UIImage?
    var date: Date?
    var quote: String = ""
    var favorite: Bool = false
    var nav: UINavigationController?
    // swiftlint:disable:next identifier_name
    var id: UUID?

    required init() {
        super.init()
        cellHeight = 830
        cellClass = DetailedEntryCell.self
    }
}
