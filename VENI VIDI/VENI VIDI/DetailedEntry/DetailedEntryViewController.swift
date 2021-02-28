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
        print(entryData.title)
        print(entryData.rate ?? "no rating")
        print(entryData.url)
        
        let detailCM = DetailedEntryContainerModel()
        detailCM.comment=entryData.comment
        detailCM.entryTitle=entryData.title
        detailCM.stars=entryData.rate
        detailCM.poster=UIImage(systemName: "star")
        loadCM(detailCM)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
}
