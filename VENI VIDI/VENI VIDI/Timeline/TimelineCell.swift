//
//  TimelineCell.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import Foundation
import DCFrame
import UIKit
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
        label.font = UIFont.systemFont(ofSize: 17)
        label.backgroundColor=UIColor.systemBlue
        return label
    }()
    
    let pictureView: UIImageView = {
        let pictureView = UIImageView()
        pictureView.contentMode = .scaleAspectFill
        pictureView.backgroundColor=UIColor.systemYellow
        pictureView.contentMode = .scaleAspectFit
        return pictureView
    }()
    
    var comment:String={
        var comment=""
        return comment
    }()
    
    override func didSelect() {
        super.didSelect()
        sendEvent(Self.touch)
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
        //let height: CGFloat = 1
        //let height: CGFloat = 1.0 / UIScreen.main.scale
        
        //pictureView.frame=bounds
        
        //label.frame = bounds.inset(by: UIEdgeInsets(top: 8, left: left, bottom: 8, right: 15))
        label.frame = CGRect(x: left+95, y: bounds.height - 95, width: bounds.width-125, height: 25)
        pictureView.frame = CGRect(x: left, y: bounds.height - 95, width: 90, height: 90)
        //separateLine.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
        starsCosmosView.frame = CGRect(x: left+95, y: bounds.height - 30, width: bounds.width-125, height: 25)
    }
    
    override func cellModelDidUpdate() {
        super.cellModelDidUpdate()
      
        label.text = cellModel.title
        print(cellModel.title)
        pictureView.image=cellModel.picture
        starsCosmosView.rating = cellModel.rating
        comment=cellModel.comment
    }
}
