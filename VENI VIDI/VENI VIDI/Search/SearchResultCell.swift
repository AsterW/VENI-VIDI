//
//  SearchResultCell.swift
//  VENI VIDI
//
//  Created by MonAster on 2021/3/22.
//
import Foundation
import DCFrame
import SnapKit

class SearchResultCellModel: DCCellModel {
    var cover: UIImage?
    var title: String = ""
    var coverURL: String = ""
    var volume: EntryData?
    
    required init() {
        super.init()
        cellHeight = 120
        cellClass = SearchResultCell.self
    }
}

class SearchResultCell: DCCell<SearchResultCellModel> {
    static let selectedVolume = DCEventID()
    
    var coverView = UIImageView()
    var titleView = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(coverView)
        contentView.addSubview(titleView)
        
        coverView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.bottom.equalTo(10)
            make.width.equalTo(100 * 9 / 16)
        }
        
        titleView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(coverView.snp.right).offset(50)
            make.width.equalTo(300)
        }
        
    }
    
    override func cellModelDidLoad() {
        super.cellModelDidLoad()
        self.titleView.text = cellModel.title
        self.coverView.image = cellModel.cover
    }
    
    override func didSelect() {
        super.didSelect()
        sendEvent(Self.selectedVolume, data: self.cellModel.volume)
    }
}
