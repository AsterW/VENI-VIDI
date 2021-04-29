//
//  CustomTagView.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 4/27/21.
//

import Foundation
import UIKit

class CustomTagView: UIView {

    var tagLabel = UITextView()
    var cancel = UIButton()

    // initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    // initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .systemPink
        addSubview(tagLabel)
        addSubview(cancel)
//        cancel.addTarget(self, action: #selector(removeTag), for: .touchUpInside)
//        textView.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width - 30, height: 30)
//        textView.backgroundColor = .systemRed
//        cancel.frame = CGRect(x: frame.maxX - 30, y: frame.minY, width: 30, height: 30)
//        cancel.setImage(UIImage(systemName: "star"), for: .normal)
    }

    @objc
    func removeTag() {
//        removeFromSuperview()
    }
}
