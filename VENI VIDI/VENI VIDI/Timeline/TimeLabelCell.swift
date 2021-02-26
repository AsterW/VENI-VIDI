//
//  TimeLabelCell.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import Foundation
import DCFrame
import UIKit

class TimeLabelCell:DCCell<TimeLabelCellModel>{
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.backgroundColor=UIColor.systemGray
        return label
    }()
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        let left: CGFloat = 15

        label.frame = CGRect(x: left, y: bounds.height - 25, width: bounds.width-30, height: 20)

    }
    
    override func cellModelDidUpdate() {
        super.cellModelDidUpdate()
        label.text = cellModel.timeLabel
    }
}
