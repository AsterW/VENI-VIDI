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

class SearchCell: DCBaseCell {
    static let textChanged = DCEventID()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        self.contentView.addSubview(view)
        view.delegate = self
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = contentView.bounds
    }
    
    private func textChanged(_ text: String) {
        setCellData(text)
        sendEvent(Self.textChanged, data: text)
    }
    
    override func cellModelDidUpdate() {
        super.cellModelDidUpdate()
        searchBar.text = getCellData(default: "")
    }
}

extension SearchCell: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textChanged(searchText)
    }
}
