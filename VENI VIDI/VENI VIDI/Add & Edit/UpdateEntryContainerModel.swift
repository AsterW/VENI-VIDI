//
//  UpdateEntryContainerModel.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 3/8/21.
//

import Foundation
import DCFrame
import UIKit

class UpdateEntryContainerModel: VVContainerModel{   
    var entryTitle:String?//should be passed by last TimelineViewController
    var poster:UIImage?
    var comment:String?
    var stars:Double?
    var date: Date?
    var nav:UINavigationController?
    
    var entryId:UUID?
    
    let searchCM = SearchCM()
    let newEntryModel=UpdateEntryCellModel()
    
    
    override func cmDidLoad() {
        super.cmDidLoad()
        
        containerTableView?.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)

        newEntryModel.nav=self.nav
        newEntryModel.service=dataService
        
        if let title=entryTitle{
            newEntryModel.entryTitle=title
        }
        else{
            //throw error
        }
        
        if let image=poster{
            newEntryModel.posterImage=image
        }
        
        if let rating=stars{
            newEntryModel.rating=rating
        }
        
        if let commentContent=comment{
            newEntryModel.comment=commentContent
        }
        
        if let id=entryId{
            newEntryModel.entryId=id
        }
        
        
        addSubmodel(searchCM)
        addSubmodel(newEntryModel)
        
    }
}
