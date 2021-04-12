//
//  QueryResult.swift
//  VENI VIDI
//
//  Created by 雲無心 on 4/12/21.
//

import Foundation
import UIKit

struct QueryResult {
    init(withMovieStruct movie: Movie) {
        type = .movie
        title = movie.title
    }

    let type: QueryContentType
    var title: String
    var cover: UIImage?
}
