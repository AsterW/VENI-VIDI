//
//  UpdateEntryCell.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 3/9/21.
//

import Foundation
import DCFrame
import SnapKit
import Cosmos

class UpdateEntryCell:DCCell<UpdateEntryCellModel>, UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    //poster is the larger image for the entry
    
    static let titleText = DCSharedDataID()
    
    var navigationController:UINavigationController={
        let navigationController=UINavigationController()
        return navigationController
    }()
    
    let poster:UIImageView={
        let poster=UIImageView()
        poster.contentMode = .scaleToFill
        poster.backgroundColor = UIColor.systemYellow
        poster.clipsToBounds = true
        poster.layer.cornerRadius=6
        return poster
    }()
    
    //user's rating for this movie/book
    let stars:CosmosView={
        let stars=CosmosView()
        return stars
    }()
    
    //user's comment for this movie/book
    var comment:UITextView={
       let comment=UITextView()
        comment.backgroundColor = UIColor.systemGray6
        comment.text="Placeholder for Notes"
        comment.accessibilityLabel="Entry Note"
        comment.layer.cornerRadius=6
        comment.font = UIFont.systemFont(ofSize: 18, weight: .medium)
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
        submitButton.backgroundColor=UIColor.systemYellow
        submitButton.setTitle("Finish", for: .normal)
        submitButton.setTitleColor(UIColor.systemGray, for: .normal)
        submitButton.tintColor=UIColor.systemGray
        submitButton.layer.cornerRadius=6
        return submitButton
    }()
    
    let commentLabel: UILabel = {
        let commentLabel = UILabel()
        commentLabel.text = "Memories: "
        commentLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return commentLabel
    }()
        
    override func setupUI() {
        super.setupUI()
        
        comment.delegate=self
        comment.textColor = UIColor.systemGray2
        
        contentView.addSubview(poster)
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(uploadData), for: .touchUpInside)
        contentView.addSubview(stars)
        contentView.addSubview(commentLabel)
        contentView.addSubview(comment)
        contentView.addSubview(submitButton)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        poster.snp.makeConstraints { (make) in
//            make.left.equalTo(15)
            make.top.equalTo(20)
            make.height.equalTo(240)
            make.width.equalTo(135)
            make.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints { (make) in
            make.edges.equalTo(poster.snp.edges)
        }
        
        stars.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.top.equalTo(poster.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(stars.snp.bottom).offset(20)
            make.height.equalTo(24)
            make.left.equalTo(15)
        }
        
        comment.snp.makeConstraints { (make) in
            make.top.equalTo(commentLabel.snp.bottom).offset(20)
            make.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(comment.snp.bottom).offset(20)
            make.left.equalTo(comment.snp.left)
            make.height.equalTo(50)
            make.width.equalTo(comment.snp.width)
            make.centerX.equalToSuperview()
        }

    }
    
    override func cellModelDidLoad() {
        super.cellModelDidLoad()
        subscribeEvent(SearchCell.cancelSearch) { [weak self] (text: String) in
            self?.cellModel.entryTitle = text
        }.and(SearchCM.searchNotEmpty) { [weak self] in
            self?.submitButton.setTitleColor(.black, for: .normal)
        }.and(SearchCM.searchEmpty) { [weak self] in
            self?.submitButton.setTitleColor(.systemGray, for: .normal)
        }
    }
    
    override func cellModelDidUpdate() {
        super.cellModelDidUpdate()
        if let nav=cellModel.nav{
            self.navigationController=nav
            print(nav.description)
        }
        
        poster.image=cellModel.posterImage
        comment.text=cellModel.comment
        button.setTitle("Choose Cover", for: .normal)
    }
    
    @objc func pickImage(){
        print("Clicked")
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        navigationController.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let photo = info[.editedImage] as? UIImage else { return }
        
        poster.image=photo
        
        navigationController.dismiss(animated: true)
        
        button.setTitle("", for: .normal)
        
    }
    
    @objc func uploadData(){
        var newTitle:String
        var newImage:UIImage?
        var newRate:Double?
        var newContent:String
        
        newTitle = cellModel.entryTitle
        
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
        
        guard newTitle != "" else { return }
        
        if let id=cellModel.entryId{
            _=cellModel.service.updateJournalEntry(withUUID: id, aboutWork: newTitle, withCoverImage: newImage, withStartDate: Date(), withFinishDate: Date(), withEntryTitle: newTitle, withEntryContent: newContent, isFavorite: false)
        } else {
            _=cellModel.service.createJournalEntry(aboutWork: newTitle, withCoverImage: newImage, withStartDate: Date(), withFinishDate: Date(), withEntryTitle: newTitle, withEntryContent: newContent, isFavorite: false)
        }

        
        if let entries=cellModel.service.fetchAllJournalEntries(){
//            print(entries.count)
//            let entryOne=entries[0]
//            print(entryOne.entryTitle ?? "No Title")
        }
        
        
        _ = navigationController.popViewController(animated: true)



    }
    
    
}
