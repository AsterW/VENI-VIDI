//
//  DetailedEntryCell.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import Foundation
import DCFrame
import Cosmos

class DetailedEntryCell:DCCell<DetailedEntryCellModel>{
    //poster is the larger image for the entry
    let poster:UIImageView={
        let poster=UIImageView()
        return poster
    }()
    
    //user-defined title for this entry
    let titleLabel:UILabel={
        let titleLabel=UILabel()
        return titleLabel
    }()
    
    //user's rating for this movie/book
    let stars:CosmosView={
        let stars=CosmosView()
        return stars
    }()
    
    //user's comment for this movie/book
    let comment:UITextField={
       let comment=UITextField()
        return comment
    }()
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(poster)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stars)
        contentView.addSubview(comment)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        let left: CGFloat = 15

        //titleLabel.frame = CGRect(x: left, y: bounds.height - 25, width: bounds.width-30, height: 20)
        titleLabel.frame = CGRect(x: left+95, y: bounds.height - 95, width: bounds.width-125, height: 25)
        poster.frame = CGRect(x: left, y: bounds.height - 195, width: 90, height: 90)
        //separateLine.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
        stars.frame = CGRect(x: left+95, y: bounds.height - 130, width: bounds.width-125, height: 25)
        comment.frame=CGRect(x: left+95, y: bounds.height - 100, width: bounds.width-125, height: 100)

    }
    
    override func cellModelDidUpdate() {
        super.cellModelDidUpdate()
        //label.text = cellModel.timeLabel
        titleLabel.text=cellModel.entryTitle
        poster.image=cellModel.posterImage
        comment.text=cellModel.comment
        if let rating=cellModel.rating{
            stars.rating = rating
        }
        else{
            //should throw error
        }
    }
    
}
