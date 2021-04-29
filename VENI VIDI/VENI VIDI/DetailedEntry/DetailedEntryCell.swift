//
//  DetailedEntryCell.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import Cosmos
import DCFrame
import Foundation

class DetailedEntryCell: DCCell<DetailedEntryCellModel> {
    var favorite: Bool = false
    // poster is the larger image for the entry
    let poster: UIImageView = {
        let poster = UIImageView()
        poster.contentMode = .scaleAspectFit
        poster.backgroundColor = UIColor.systemYellow
        poster.layer.cornerRadius = 10
        poster.clipsToBounds = true
        return poster
    }()

    // user's rating for this movie/book
    let stars: CosmosView = {
        let stars = CosmosView()
        // stars.backgroundColor=UIColor.systemGray
        stars.isUserInteractionEnabled = false
        stars.layer.cornerRadius = 4
        return stars
    }()

    let favoriteButton: UIButton = {
        let favoriteButton = UIButton()
        return favoriteButton
    }()

    // user's comment for this movie/book
    let comment: UITextView = {
        let comment = UITextView()
        comment.backgroundColor = UIColor.systemGray6
        comment.layer.cornerRadius = 10
        comment.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        comment.textColor = UIColor.systemGray
        comment.isEditable = false
        return comment
    }()

    let smallPoster: UIImageView = {
        let smallPoster = UIImageView()
        smallPoster.contentMode = .scaleAspectFit
        smallPoster.backgroundColor = UIColor.systemGray6
        smallPoster.layer.cornerRadius = 6
        smallPoster.clipsToBounds = true
        return smallPoster
    }()

    let quote: NewTextView = {
        let quote = NewTextView()

        quote.textAlignment = .center
        // quote.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        quote.font = UIFont.italicSystemFont(ofSize: 18)
        quote.textColor = UIColor.systemYellow
        quote.isEditable = false

        return quote
    }()

    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textAlignment = .center
        dateLabel.textColor = .systemYellow
        return dateLabel
    }()

    func setFavoriteImage() {
        if favorite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    override func setupUI() {
        super.setupUI()

        contentView.addSubview(poster)
        contentView.addSubview(stars)
        contentView.addSubview(favoriteButton)
        setFavoriteImage()
        contentView.addSubview(comment)

        contentView.addSubview(smallPoster)
        contentView.addSubview(quote)

        contentView.addSubview(dateLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        print(bounds)
        let left: CGFloat = 15

        // poster.frame = CGRect(x: left, y: 15, width: bounds.width - 30, height: 180)
        smallPoster.frame = CGRect(x: left, y: 80, width: 120, height: 180)
        quote.frame = CGRect(x: left + 135, y: 80, width: bounds.width - 135, height: 180)
        stars.frame = CGRect(x: left, y: 285, width: (bounds.width - 145) / 3, height: 30)
        favoriteButton.frame = CGRect(x: left + (bounds.width - 30) / 3, y: 285, width: (bounds.width - 30) / 3, height: 30)
        dateLabel.frame = CGRect(x: left + 2 * (bounds.width - 30) / 3, y: 285, width: (bounds.width - 30) / 3, height: 30)
        comment.frame = CGRect(x: left, y: 330, width: bounds.width - 30, height: 335)
    }

    override func cellModelDidUpdate() {
        super.cellModelDidUpdate()
        poster.image = cellModel.posterImage
        smallPoster.image = cellModel.posterImage
        comment.text = cellModel.comment
        quote.text = cellModel.quote
        favorite = cellModel.favorite
        setFavoriteImage()

//        quote.text = "The Quote from Book. \n Querer es poder."

        if let date = cellModel.date {
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .short
            dateLabel.text = formatter1.string(from: date)
        }

        if let rating = cellModel.rating {
            stars.rating = rating
        } else {
            // should throw error
        }
    }
}
