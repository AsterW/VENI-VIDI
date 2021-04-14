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
    // poster is the larger image for the entry
    let poster: UIImageView = {
        let poster = UIImageView()
        poster.contentMode = .scaleAspectFit
        poster.backgroundColor = UIColor.systemYellow
        poster.layer.cornerRadius = 10
        return poster
    }()

    // user-defined title for this entry
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.systemGray6
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 6
        return titleLabel
    }()

    // user's rating for this movie/book
    let stars: CosmosView = {
        let stars = CosmosView()
        // stars.backgroundColor=UIColor.systemGray
        stars.isUserInteractionEnabled = false
        stars.layer.cornerRadius = 4
        return stars
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
        smallPoster.backgroundColor = UIColor.systemYellow
        smallPoster.layer.cornerRadius = 6
        return smallPoster
    }()

    let quote: UITextView = {
        let quote = UITextView()
        // quote.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        quote.font = UIFont.italicSystemFont(ofSize: 18)
        quote.textColor = UIColor.systemYellow
        quote.isEditable = false
        return quote
    }()

    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        return dateLabel
    }()

    override func setupUI() {
        super.setupUI()

        contentView.addSubview(poster)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stars)
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
        stars.frame = CGRect(x: left + 135, y: 330, width: (bounds.width - 145) / 2, height: 30)

        dateLabel.frame = CGRect(x: left + 180 + (bounds.width - 145) / 2, y: 330, width: (bounds.width - 145) / 2, height: 30)
        titleLabel.frame = CGRect(x: left, y: 15, width: bounds.width - 30, height: 50)
        comment.frame = CGRect(x: left, y: 375, width: bounds.width - 30, height: 350)
    }

    override func cellModelDidUpdate() {
        super.cellModelDidUpdate()
        titleLabel.text = cellModel.entryTitle
        poster.image = cellModel.posterImage
        smallPoster.image = cellModel.posterImage
        comment.text = cellModel.comment
        quote.text = "The Quote from Book"
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 40
//        let attributes = [NSAttributedString.Key.paragraphStyle : style]
//        comment.attributedText = NSAttributedString(string: cellModel.comment, attributes:attributes)

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
