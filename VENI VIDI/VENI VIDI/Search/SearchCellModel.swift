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
    static let searchText = DCSharedDataID()
    static let cancelSearch = DCEventID()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        self.contentView.addSubview(view)
        view.delegate = self
        view.showsCancelButton = true
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
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
    
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        shareData(searchBar.text, to: Self.searchText)
//    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shareData(searchBar.text, to: Self.searchText)
        sendEvent(Self.cancelSearch, data: searchBar.text)
    }
    
    override func cellModelDidUpdate() {
        super.cellModelDidUpdate()
        searchBar.text = getCellData(default: "")
    }
    
    override func cellModelDidLoad() {
        super.cellModelDidLoad()
        
        subscribeData(UpdateEntryCell.titleText) { [weak self] (text: String) in
            self?.setCellData(text)
        }
        
        subscribeEvent(SearchResultCell.selectedVolume) { [weak self] (volume: EntryData) in
            self?.setCellData(volume.title)
            self?.searchBar.text = volume.title
            self?.sendEvent(Self.cancelSearch, data: volume.title)
        }
    }
}

extension SearchCell: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textChanged(searchText)
    }
}
