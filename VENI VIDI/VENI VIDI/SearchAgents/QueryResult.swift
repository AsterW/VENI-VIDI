//
//  QueryResult.swift
//  VENI VIDI
//
//  Created by 雲無心 on 4/12/21.
//

import Foundation
import UIKit

struct QueryResult {
    init(withMovieStruct movie: TMDBMovieDataStruct, withTimeStamp timeStamp: TimeInterval) {
        type = .movie
        title = movie.title
        self.timeStamp = timeStamp
    }

    init(withTVStruct tvShow: TMDBTVDataStruct, withTimeStamp timeStamp: TimeInterval) {
        type = .tvShow
        title = tvShow.name
        self.timeStamp = timeStamp
    }

    let type: QueryContentType
    let timeStamp: TimeInterval
    var title: String
    var cover: UIImage?
}
