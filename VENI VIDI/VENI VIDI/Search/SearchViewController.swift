//
//  SearchViewController.swift
//  VENI VIDI
//
//  Created by MonAster on 2021/3/8.
//

import Foundation
import DCFrame
import SnapKit
import UIKit

class SearchViewController: DCViewController{
    let searchCM = SearchCM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dcTableView.backgroundColor = .clear
        view.backgroundColor = .clear
        navigationItem.title = "Search"
        loadCM(searchCM)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}
