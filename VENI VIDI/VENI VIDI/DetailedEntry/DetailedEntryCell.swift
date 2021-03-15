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
        poster.layer.cornerRadius=10
        return poster
    }()
    
    //user-defined title for this entry
    let titleLabel:UILabel={
        let titleLabel=UILabel()
        titleLabel.backgroundColor=UIColor.systemGray6
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textAlignment=NSTextAlignment.center
        titleLabel.layer.masksToBounds=true
        titleLabel.layer.cornerRadius=6
        return titleLabel
    }()
    
    //user's rating for this movie/book
    let stars:CosmosView={
        let stars=CosmosView()
        //stars.backgroundColor=UIColor.systemGray
        stars.layer.cornerRadius=4
        return stars
    }()
    
    //user's comment for this movie/book
    let comment:UITextField={
       let comment=UITextField()
        comment.backgroundColor=UIColor.systemGray6
        comment.layer.cornerRadius=10
        return comment
    }()
    
    let smallPoster:UIImageView={
        let smallPoster=UIImageView()
        smallPoster.contentMode = .scaleAspectFit
        smallPoster.backgroundColor=UIColor.systemYellow
        smallPoster.layer.cornerRadius=6
        return smallPoster
    }()
    
    let dateLabel:UILabel={
        let dateLabel=UILabel()
        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        dateLabel.text=formatter1.string(from: today)
        return dateLabel
    }()
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(poster)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stars)
        contentView.addSubview(comment)
        
        contentView.addSubview(smallPoster)
        
        contentView.addSubview(dateLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        print(bounds)
        let left: CGFloat = 15


        //titleLabel.frame = CGRect(x: left, y: 15, width: bounds.width-30, height: 50)
        poster.frame = CGRect(x: left, y: 15, width: bounds.width-30, height: 180)
        //separateLine.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
        smallPoster.frame = CGRect(x: left, y: 210, width: 100, height: 150)
        stars.frame = CGRect(x: left+115, y: 330, width: (bounds.width-145)/2, height: 30)
        
        dateLabel.frame=CGRect(x: left+180+(bounds.width-145)/2, y: 330, width: (bounds.width-145)/2, height: 30)
        titleLabel.frame = CGRect(x: left+115, y: 210, width: bounds.width-145, height: 50)
        comment.frame=CGRect(x: left, y: 375, width: bounds.width-30, height: 350)

    }
    
    override func cellModelDidUpdate() {
        super.cellModelDidUpdate()
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
