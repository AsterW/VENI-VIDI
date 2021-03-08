//
//  UpdateEntryContainerModel.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 3/8/21.
//

import Foundation
import DCFrame
import UIKit

class UpdateEntryContainerModel: DCContainerModel{
    var entryTitle:String?//should be passed by last TimelineViewController
    var poster:UIImage?
    var comment:String?
    var stars:Double?
    var date: Date?
    
    override func cmDidLoad() {
        super.cmDidLoad()
        
        let newEntryModel=UpdateEntryCellModel()
        addSubmodel(newEntryModel)

    }
}
