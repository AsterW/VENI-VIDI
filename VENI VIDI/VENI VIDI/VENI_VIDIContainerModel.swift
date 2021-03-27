//
//  VENI_VIDIContainerModel.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 3/16/21.
//

import Foundation
import DCFrame
import UIKit

class VVContainerModel: DCContainerModel {
    public let journalEntryService = JournalEntryService(coreDataStack: CoreDataStack())
    
    override func cmDidLoad() {
        super.cmDidLoad()
    }

    
}

