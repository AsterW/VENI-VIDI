//
//  TMDBSearchAgent.swift
//  VENI VIDI
//
//  Created by 雲無心 on 3/29/21.
//

import Foundation
import UIKit

class TMDBSearchAgent: DatabaseSpecificSearchAgent {
    let agentType: QueryContentType = .movie
    let apiUrl: String = "https://api.themoviedb.org/3/movie"
    let apiKey: String = "29748b6586282540605ffb47f2378ad4"
    let delegate: DatabaseSpecificSearchAgentDelegate? = nil

    let imageUrl500 = "https://image.tmdb.org/t/p/w500"
    let imageUrlOriginal = "https://image.tmdb.org/t/p/original"

    func query(withKeyword keyword: String, withTimeStamp timeStamp: Date) {
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "query", value: keyword),
        ]

        guard let urlComponent = components.url?.absoluteString else { return }
        guard let queryUrl = URL(string: apiUrl + urlComponent) else { return }
        guard let data = try? Data(contentsOf: queryUrl) else { return }

        let parsedData = try? JSONDecoder().decode(APIResults.self, from: data)
        guard let queriedMovies = parsedData?.results else { return }

        var queryResults: [QueryResult] = []
        for movie in queriedMovies {
            var result = QueryResult(withMovieStruct: movie)
            result.cover = cacheImage(withPosterPath: movie.poster_path)
            queryResults.append(result)
        }

        delegate?.receivedQueryResult(queryResults, for: .movie, withTimeStamp: timeStamp)
    }

    func cacheImage(withPosterPath posterPath: String?) -> UIImage? {
        if let path = posterPath {
            let imageUrl = URL(string: imageUrl500 + path)
            let data = try? Data(contentsOf: imageUrl!)
            return UIImage(data: data!)
        } else {
            return nil
        }
    }
}
