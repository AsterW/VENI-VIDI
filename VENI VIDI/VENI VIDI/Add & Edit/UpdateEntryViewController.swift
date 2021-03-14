//
//  UpdateEntryViewController.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 3/8/21.
//

import Foundation
import DCFrame
import UIKit

class UpdateEnrtyViewController: DCViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Update Entry")
        
        let newEntryCM = UpdateEntryContainerModel()

        loadCM(newEntryCM)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    

}
