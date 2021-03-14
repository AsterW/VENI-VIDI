//
//  SearchViewController.swift
//  VENI VIDI
//
//  Created by MonAster on 2021/3/8.
//

import Foundation
import DCFrame
import UIKit

class SearchViewController: DCViewController{
    let searchCM = DCContainerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dcTableView.backgroundColor = .clear
        view.backgroundColor = .clear
        navigationItem.title = "Search"
        
        searchCM.addSubmodel(SearchCellModel())
        loadCM(searchCM)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}
