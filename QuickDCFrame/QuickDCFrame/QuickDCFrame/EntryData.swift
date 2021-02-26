//
//  EntryData.swift
//  QuickDCFrame
//
//  Created by 马晓雯 on 2/21/21.
//

import Foundation
import UIKit

struct  EntryData:Decodable{
    var title:String = ""
    var url:String = ""
    var date:Int?
    var rate:Double?
}
