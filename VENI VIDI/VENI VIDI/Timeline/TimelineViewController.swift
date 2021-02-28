//
//  TimelineViewController.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import Foundation
import DCFrame
import UIKit

class TimelineViewController: DCViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EDC.subscribeEvent(TimelineCell.touch, target: self) {[weak self] (data:EntryData) in
            print("pushing View Controller")
            guard let `self` = self else {
                return
            }
            let vc = DetailedEntryViewController()
            vc.entryData.title=data.title
            vc.entryData.comment=data.comment
            vc.entryData.rate=data.rate
            vc.entryData.url=data.url
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let simpleListCM = SimpleListContainerModel()
        loadCM(simpleListCM)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

}
