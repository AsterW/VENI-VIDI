//
//  SearchCellModel.swift
//  VENI VIDI
//
//  Created by MonAster on 2021/3/9.
//

import Foundation
import DCFrame
import SnapKit
import UIKit

class SearchCellModel: DCCellModel{
    var title: String = "some title"
    var picture: UIImage?
    var rating: Double = 0
    var comment: String=""
    
    required init() {
        super.init()
        
        cellHeight = 100
        cellClass = SearchCell.self
    }

}

class SearchCell: DCCell<SearchCellModel>, UISearchBarDelegate {
    let searchBar = UISearchBar()
    
    override func setupUI() {
        super.setupUI()
        
        self.backgroundColor = .clear
        contentView.addSubview(searchBar)
        
        searchBar.backgroundColor = .clear
        searchBar.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
