//
//  TMDBDataStructs.swift
//  VENI VIDI
//
//  Created by 雲無心 on 3/29/21.
//

import Foundation
import UIKit

struct APIResults: Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let title: String
    let id: Int!
    let poster_path: String?
    let release_date: String
    let vote_average: Double
    let overview: String
    let vote_count: Int!
}
