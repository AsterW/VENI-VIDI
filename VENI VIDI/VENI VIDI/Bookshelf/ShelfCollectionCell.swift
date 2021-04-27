//
//  ShelfCollectionCell.swift
//  VENI VIDI
//
//  Created by MonAster on 2021/4/26.
//

import UIKit

class ShelfCollectionCell: UICollectionViewCell {
    var cover = UIImageView()
    var title = UILabel()
    let coverWidth = 100
    lazy var coverHeight = coverWidth * 16 / 9

    static let identifier = "ShelfCollectionCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
        configureSubview()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubview() {
        contentView.addSubview(cover)
        contentView.addSubview(title)
    }

    func configureSubview() {
        cover.layer.cornerRadius = 5
        cover.clipsToBounds = true
        cover.snp.makeConstraints { make in
            make.width.equalTo(coverWidth)
            make.height.equalTo(coverHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        title.textAlignment = .center
        title.snp.makeConstraints { make in
            make.top.equalTo(cover.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(title.font.pointSize)
        }
    }

    func set(withEntry entry: JournalEntry) {

        if let imageData = entry.image {
            cover.image = UIImage(data: imageData)
        }

        title.text = entry.entryTitle
        title.font = UIFont.systemFont(ofSize: 16)
    }

    func setPlaceHolder() {
        cover.image = UIImage(named: "logo_background")
        title.text = "VENI VIDI"
        title.font = UIFont.systemFont(ofSize: 16)
        title.textColor = .systemGray2
    }
}
