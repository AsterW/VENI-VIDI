//
//  DetailedEntryContainerModel.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import Foundation
import DCFrame
import UIKit

class DetailedEntryContainerModel: DCContainerModel{
    var entryTitle:String?//should be passed by last TimelineViewController
    var poster:UIImage?
    var comment:String?
    var stars:Double?
    
    override func cmDidLoad() {
        super.cmDidLoad()
        
        let detailModel=DetailedEntryCellModel()
        if let title=entryTitle{
            detailModel.entryTitle=title
        }
        else{
            //throw error
        }
        
        if let image=poster{
            detailModel.posterImage=image
        }
        
        if let rating=stars{
            detailModel.rating=rating
        }
        
        if let commentContent=comment{
            detailModel.comment=commentContent
        }

    }
}
