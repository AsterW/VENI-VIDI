//
//  UpdateEntryCell.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 3/9/21.
//

import Foundation
import DCFrame
import Cosmos

class UpdateEntryCell:DCCell<UpdateEntryCellModel>, UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    //poster is the larger image for the entry
    var navigationController:UINavigationController={
        let navigationController=UINavigationController()
        return navigationController
    }()
    
    let poster:UIImageView={
        let poster=UIImageView()
        poster.contentMode = .scaleAspectFit
        poster.backgroundColor=UIColor.systemYellow
        poster.layer.cornerRadius=6
        return poster
    }()
    
    //user-defined title for this entry
    var titleLabel:UITextView={
        let titleLabel=UITextView()
        titleLabel.backgroundColor=UIColor.systemGray6
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.text="Placeholder for Title"
        titleLabel.accessibilityLabel="Entry Title"
        titleLabel.layer.cornerRadius=6
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
        comment.accessibilityLabel="Entry Note"
        comment.layer.cornerRadius=6
        return comment
    }()
    
    let button:UIButton={
        let button=UIButton()
        button.setTitle("Click to Upload Image", for: .normal)
        button.setTitleColor(UIColor.systemGray2, for: .normal)
        return button
    }()
    
    let submitButton:UIButton={
        let submitButton=UIButton()
        submitButton.backgroundColor=UIColor.systemGray6
        submitButton.setTitle("Add Movie", for: .normal)
        submitButton.setTitleColor(UIColor.systemGray, for: .normal)
        submitButton.tintColor=UIColor.systemGray
        submitButton.layer.cornerRadius=6
        return submitButton
    }()
        
    override func setupUI() {
        super.setupUI()
        
        titleLabel.delegate=self
        comment.delegate=self
        
        titleLabel.textColor = UIColor.systemGray2
        comment.textColor = UIColor.systemGray2
        
        contentView.addSubview(poster)
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(uploadData), for: .touchUpInside)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stars)
        contentView.addSubview(comment)
        contentView.addSubview(submitButton)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        print(bounds)
        let left: CGFloat = 15


        titleLabel.frame = CGRect(x: left, y: 30, width: bounds.width-30, height: 50)
        poster.frame = CGRect(x: left, y: 100, width: bounds.width-30, height: 200)
        button.frame = poster.frame
        stars.frame = CGRect(x: left, y: 350, width: bounds.width-145, height: 30)
        comment.frame=CGRect(x: left, y: 395, width: bounds.width-30, height: 200)
        submitButton.frame=CGRect(x: left, y: 645, width: bounds.width-30, height: 50)

    }
    
    override func cellModelDidUpdate() {
        super.cellModelDidUpdate()
        if let nav=cellModel.nav{
            self.navigationController=nav
            print(nav.description)
        }
        
        titleLabel.text=cellModel.entryTitle
        poster.image=cellModel.posterImage
        //smallPoster.image=cellModel.posterImage
        comment.text=cellModel.comment
        button.setTitle("Click to Upload New Image", for: .normal)
    }
    
    @objc func pickImage(){
        print("Clicked")
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        navigationController.present(picker, animated: true, completion: nil)
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let photo = info[.editedImage] as? UIImage else { return }
        
        poster.image=photo
        
        navigationController.dismiss(animated: true)
        
        button.setTitle("", for: .normal)

        //poster.becomeFirstResponder()
        
    }
    
    @objc func uploadData(){
        var newTitle:String
        var newImage:UIImage?
        var newRate:Double?
        var newContent:String
        
        if let title=titleLabel.text{
            newTitle=title
        }
        else{
            newTitle=""
        }
        
        if let image=poster.image{
            newImage=image
        }
        
        if let content=comment.text{
            newContent=content
        }
        else{
            newContent=""
        }
        
        newRate = stars.rating
        
        
        print("Upload Data")
        
        if let id=cellModel.entryId{
            _=cellModel.service.updateJournalEntry(withUUID: id, aboutWork: newTitle, withCoverImage: newImage, withStartDate: Date(), withFinishDate: Date(), withEntryTitle: newTitle, withEntryContent: newContent, isFavorite: false)
        }
//        _=cellModel.service.createJournalEntry(aboutWork: newTitle, withCoverImage: newImage, withStartDate: Date(), withFinishDate: Date(), withEntryTitle: newTitle, withEntryContent: newContent, isFavorite: false)
        
        if let entries=cellModel.service.fetchAllJournalEntries(){
            print(entries.count)
//            let entryOne=entries[0]
//            print(entryOne.entryTitle ?? "No Title")
        }
        
        
        _ = navigationController.popViewController(animated: true)



    }
    
    
}
