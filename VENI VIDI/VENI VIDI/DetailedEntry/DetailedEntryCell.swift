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
        poster.contentMode = .scaleAspectFit
        poster.backgroundColor=UIColor.systemYellow
        return poster
    }()
    
    //user-defined title for this entry
    let titleLabel:UILabel={
        let titleLabel=UILabel()
        titleLabel.backgroundColor=UIColor.systemGray
        titleLabel.font = UIFont.systemFont(ofSize: 30)
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
        comment.backgroundColor=UIColor.systemGray2
        return comment
    }()
    
    let smallPoster:UIImageView={
        let smallPoster=UIImageView()
        smallPoster.contentMode = .scaleAspectFit
        smallPoster.backgroundColor=UIColor.systemYellow
        return smallPoster
    }()
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(poster)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stars)
        contentView.addSubview(comment)
        
        contentView.addSubview(smallPoster)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        print(bounds)
        let left: CGFloat = 15


        //titleLabel.frame = CGRect(x: left, y: 15, width: bounds.width-30, height: 50)
        poster.frame = CGRect(x: left, y: 15, width: bounds.width-30, height: 150)
        //separateLine.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
        smallPoster.frame = CGRect(x: left, y: 180, width: 100, height: 150)
        stars.frame = CGRect(x: left+115, y: 300, width: bounds.width-145, height: 30)
        comment.frame=CGRect(x: left, y: 345, width: bounds.width-30, height: 350)

    }
    
    override func cellModelDidUpdate() {
        super.cellModelDidUpdate()
        //label.text = cellModel.timeLabel
        titleLabel.text=cellModel.entryTitle
        poster.image=cellModel.posterImage
        smallPoster.image=cellModel.posterImage
        comment.text=cellModel.comment
        if let rating=cellModel.rating{
            stars.rating = rating
        }
        else{
            //should throw error
        }
    }
    
}
