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
        
        EDC.subscribeEvent(TimelineCell.touch, target: self) {
            print("pushing View Controller")
            let vc = DetailedEntryViewController()
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
        let simpleListCM = SimpleListContainerModel()
        loadCM(simpleListCM)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

}
