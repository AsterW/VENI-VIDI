//
//  TimelineCell.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import Foundation
import DCFrame
import UIKit
import SnapKit
import Cosmos

class TimelineCell: DCCell<TimelineCellModel>{
    static let touch = DCEventID()
    //Outlets
    let starsCosmosView: CosmosView = {
        let starsCosmosView = CosmosView()
        return starsCosmosView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.backgroundColor=UIColor.systemGray6
        label.layer.masksToBounds=true
        label.layer.cornerRadius=4
        return label
    }()
    
    let pictureView: UIImageView = {
        let pictureView = UIImageView()
        pictureView.contentMode = .scaleAspectFill
        pictureView.backgroundColor=UIColor.systemGray6
        pictureView.contentMode = .scaleAspectFit
        pictureView.accessibilityLabel=""
        return pictureView
    }()
    
    var comment:String={
        var comment=""
        return comment
    }()
    
    override func didSelect() {
        super.didSelect()
        if let data=cellModel.entryId{
            sendEvent(Self.touch,data: data)
        }
        
    }
    

    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(label)
        contentView.addSubview(pictureView)
        contentView.addSubview(starsCosmosView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        let left: CGFloat = 15
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(pictureView.snp.right).offset(10)
            make.height.equalTo(25)
            make.top.equalToSuperview().inset(10)
//            make.top.equalTo(95)
        }
        
        

//        label.frame = CGRect(x: left+95, y: bounds.height - 95, width: bounds.width-125, height: 25)
        pictureView.frame = CGRect(x: left, y: bounds.height - 95, width: 90, height: 90)
        //separateLine.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
        starsCosmosView.frame = CGRect(x: left+95, y: bounds.height - 30, width: bounds.width-125, height: 25)
    }
    
    override func cellModelDidUpdate() {
        super.cellModelDidUpdate()
      
        label.text = cellModel.title
        print(cellModel.title)
        pictureView.image=cellModel.picture
        pictureView.accessibilityLabel=cellModel.title
        starsCosmosView.rating = cellModel.rating
        print("RATING \(cellModel.rating)")
        comment=cellModel.comment
    }
}
