//
//  UpdateEntryCell.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 3/9/21.
//

import Foundation
import DCFrame
import Cosmos

class UpdateEntryCell:DCCell<UpdateEntryCellModel>, UITextViewDelegate{
    //poster is the larger image for the entry
    let poster:UIImageView={
        let poster=UIImageView()
        poster.contentMode = .scaleAspectFit
        poster.backgroundColor=UIColor.systemYellow
        return poster
    }()
    
    //user-defined title for this entry
    var titleLabel:UITextView={
        let titleLabel=UITextView()
        titleLabel.backgroundColor=UIColor.systemGray6
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.text="Placeholder for Title"
        
        return titleLabel
    }()
    
    //user's rating for this movie/book
    let stars:CosmosView={
        let stars=CosmosView()
        return stars
    }()
    
    //user's comment for this movie/book
    var comment:UITextView={
       let comment=UITextView()
        comment.backgroundColor=UIColor.systemGray6
        comment.text="Placeholder for Notes"
        return comment
    }()
    
    
    override func setupUI() {
        super.setupUI()
        
        titleLabel.delegate=self
        comment.delegate=self
        
        titleLabel.textColor = UIColor.systemGray2
        comment.textColor = UIColor.systemGray2
        
        contentView.addSubview(poster)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stars)
        contentView.addSubview(comment)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        print(bounds)
        let left: CGFloat = 15


        titleLabel.frame = CGRect(x: left, y: 30, width: bounds.width-30, height: 50)
        poster.frame = CGRect(x: left, y: 100, width: bounds.width-30, height: 150)
        //separateLine.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
        stars.frame = CGRect(x: left, y: 350, width: bounds.width-145, height: 30)
        comment.frame=CGRect(x: left, y: 395, width: bounds.width-30, height: 300)

    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.systemGray2 {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    
}
