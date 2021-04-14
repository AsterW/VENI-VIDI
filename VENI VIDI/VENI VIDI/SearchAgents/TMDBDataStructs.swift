//
//  TMDBDataStructs.swift
//  VENI VIDI
//
//  Created by 雲無心 on 3/29/21.
//

import Foundation
import UIKit

// MARK: - TMDB Movie related structs

struct TMDBMovieQueryResults: Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [TMDBMovieDataStruct]
}

struct TMDBMovieDataStruct: Decodable {
    let title: String
    let id: Int!
    let poster_path: String?
    let release_date: String
    let vote_average: Double
    let overview: String
    let vote_count: Int!
}

// MARK: - TMDB TV Show related structs

struct TMDBTVQueryResults: Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [TMDBTVDataStruct]
}

struct TMDBTVDataStruct: Decodable {
    let name: String
    let id: Int!
    let poster_path: String?
    let first_air_date: String
    let vote_average: Double
    let overview: String
    let vote_count: Int!
}
