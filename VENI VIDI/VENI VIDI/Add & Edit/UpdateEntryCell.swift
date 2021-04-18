//
//  UpdateEntryCell.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 3/9/21.
//

import Cosmos
import DCFrame
import Foundation
import SnapKit

class UpdateEntryCell: DCCell<UpdateEntryCellModel>, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    static let titleText = DCSharedDataID()

    var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()

    var favorite: Bool = false

    let poster: UIImageView = {
        let poster = UIImageView()
        poster.alpha = 0.75
        poster.contentMode = .scaleToFill
        poster.clipsToBounds = true
        poster.layer.cornerRadius = 6
        return poster
    }()

    let favoriteButton: UIButton = {
        let favoriteButton = UIButton()
        return favoriteButton
    }()

    // user's rating for this movie/book
    let stars: CosmosView = {
        let stars = CosmosView()
        return stars
    }()

    // user's comment for this movie/book
    var comment: UITextView = {
        let comment = UITextView()
        comment.backgroundColor = UIColor.systemGray6
        comment.text = "Placeholder for Notes"
        comment.accessibilityLabel = "Entry Note"
        comment.layer.cornerRadius = 6
        comment.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return comment
    }()

    let button: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.systemGray2, for: .normal)
        return button
    }()

    let submitButton: UIButton = {
        let submitButton = UIButton()
        submitButton.backgroundColor = UIColor.systemYellow
        submitButton.setTitle("Finish", for: .normal)
        submitButton.setTitleColor(UIColor.systemGray, for: .normal)
        submitButton.tintColor = UIColor.systemGray
        submitButton.layer.cornerRadius = 6
        return submitButton
    }()

    let commentLabel: UILabel = {
        let commentLabel = UILabel()
        commentLabel.text = "Memories: "
        commentLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return commentLabel
    }()

    let quoteLabel: UILabel = {
        let quoteLabel = UILabel()
        quoteLabel.text = "The Quote: "
        quoteLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return quoteLabel
    }()

    let quote: NewTextView = {
        let quote = NewTextView()
        quote.text = "This is a quotation:)"
        quote.textAlignment = .center
        quote.backgroundColor = .systemGray6
        quote.font = UIFont.italicSystemFont(ofSize: 18)
        quote.textColor = .systemYellow
        return quote
    }()

    override func setupUI() {
        super.setupUI()

        comment.delegate = self
        comment.textColor = UIColor.systemGray2

        contentView.addSubview(poster)
        contentView.addSubview(favoriteButton)

        contentView.addSubview(button)
        button.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(uploadData), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(favoriteEntry), for: .touchUpInside)
        setFavoriteImage()
        contentView.addSubview(stars)
        contentView.addSubview(commentLabel)
        contentView.addSubview(comment)
        contentView.addSubview(quoteLabel)
        contentView.addSubview(quote)
        contentView.addSubview(submitButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        poster.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.height.equalTo(240)
            make.width.equalTo(135)
//            make.centerX.equalToSuperview()
            make.left.equalTo(15)
        }

        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.right.equalTo(-15)
        }

        button.snp.makeConstraints { make in
            make.edges.equalTo(poster.snp.edges)
        }

        button.imageView?.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50 * 806 / 980)
        }

        stars.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(poster.snp.bottom).offset(20)
            make.left.equalTo(15)
//            make.centerX.equalToSuperview()
        }

        quoteLabel.snp.makeConstraints { make in
            make.top.equalTo(stars.snp.bottom).offset(20)
            make.height.equalTo(24)
            make.left.equalTo(15)
        }

        quote.snp.makeConstraints { make in
            make.top.equalTo(quoteLabel.snp.bottom).offset(20)
            make.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
        }

        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(quote.snp.bottom).offset(20)
            make.height.equalTo(24)
            make.left.equalTo(15)
        }

        comment.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(20)
            make.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
        }

        submitButton.snp.makeConstraints { make in
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
        }.and(SearchResultCell.selectedVolume) { [weak self] (volume: EntryData) in
            let str = volume.url.replacingOccurrences(of: "http:", with: "https:")
            guard let url = URL(string: str) else { return }

            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self?.poster.image = UIImage(data: data)
                }
            }

            task.resume()
        }
    }

    override func cellModelDidUpdate() {
        print("Updating cell model")
        super.cellModelDidUpdate()
        if let nav = cellModel.nav {
            navigationController = nav
            print(nav.description)
        }

        poster.image = cellModel.posterImage
        comment.text = cellModel.comment
        quote.text = cellModel.quote
        stars.rating = cellModel.rating ?? 0
        favorite = cellModel.favorite
        setFavoriteImage()
    }

    func setFavoriteImage() {
        if favorite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    @objc func favoriteEntry() {
        print("Click heart")
        if favorite {
            favorite = false
            setFavoriteImage()
        } else {
            favorite = true
            setFavoriteImage()
        }
    }

    @objc func pickImage() {
        print("Clicked")
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        navigationController.present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let photo = info[.editedImage] as? UIImage else { return }

        poster.image = photo

        navigationController.dismiss(animated: true)

        button.setTitle("", for: .normal)
    }

    @objc func uploadData() {
        var newTitle: String
        var newImage: UIImage?
        var newRate: Double?
        var newContent: String
        var newQuote: String

        newTitle = cellModel.entryTitle

        if let image = poster.image {
            newImage = image
        }

        if let content = comment.text {
            newContent = content
        } else {
            newContent = ""
        }

        if let quote = quote.text {
            newQuote = quote
        } else {
            newQuote = ""
        }

        newRate = stars.rating

        guard newTitle != "" else { return }

        if let id = cellModel.entryId {
            if let rating = newRate {
                _ = cellModel.service.updateJournalEntry(withUUID: id, aboutWork: newTitle, withCoverImage: newImage, withEntryTitle: newTitle, withEntryContent: newContent, withQuote: newQuote, withRating: Int(rating), isFavorite: favorite)
            } else {
                _ = cellModel.service.updateJournalEntry(withUUID: id, aboutWork: newTitle, withCoverImage: newImage, withEntryTitle: newTitle, withEntryContent: newContent, withQuote: newQuote, withRating: 0, isFavorite: favorite)
            }
        } else {
            if let rating = newRate {
                _ = cellModel.service.createJournalEntry(aboutWork: newTitle, withCoverImage: newImage, withStartDate: Date(), withFinishDate: Date(), withEntryTitle: newTitle, withEntryContent: newContent, withQuote: newQuote, withRating: Int(rating), isFavorite: favorite)
            } else {
                _ = cellModel.service.createJournalEntry(aboutWork: newTitle, withCoverImage: newImage, withStartDate: Date(), withFinishDate: Date(), withEntryTitle: newTitle, withEntryContent: newContent, withQuote: newQuote, withRating: 0, isFavorite: favorite)
            }
        }

//        if let entries = cellModel.service.fetchAllJournalEntries() {
//            print(entries.count)
//            let entryOne=entries[0]
//            print(entryOne.entryTitle ?? "No Title")
//        }

        _ = navigationController.popViewController(animated: true)
    }
}
