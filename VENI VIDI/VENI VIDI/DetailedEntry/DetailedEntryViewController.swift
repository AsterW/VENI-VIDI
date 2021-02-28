//
//  DetailedEntryViewController.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import Foundation
import DCFrame
import UIKit

class DetailedEntryViewController: DCViewController{
    var entryData = EntryData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detailCM = DetailedEntryContainerModel()
        loadCM(detailCM)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
}
