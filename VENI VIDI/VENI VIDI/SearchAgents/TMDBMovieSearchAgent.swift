//
//  TMDBSearchAgent.swift
//  VENI VIDI
//
//  Created by 雲無心 on 3/29/21.
//

import Foundation
import UIKit

class TMDBMovieSearchAgent: DatabaseSpecificSearchAgent {
    internal let agentType: QueryContentType = .movie
    private let apiUrl: String = "https://api.themoviedb.org/3/search/movie"
    private let apiKey: String = "29748b6586282540605ffb47f2378ad4"

    private let imageUrl500 = "https://image.tmdb.org/t/p/w500"
    private let imageUrlOriginal = "https://image.tmdb.org/t/p/original"

    func query(withKeyword keyword: String, withTimeStamp timeStamp: TimeInterval, withCompletionHandler completionHandler: @escaping (Result<[QueryResult], QueryAgentError>) -> Void) {
        var urlComponents = URLComponents(string: apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "query", value: keyword),
        ]

        guard let requestURL = urlComponents?.url?.absoluteURL else { completionHandler(.failure(.urlError))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: requestURL) { data, _, _ in
            guard let acquiredData = data else {
                completionHandler(.failure(.noData))
                return
            }
            guard let parsedData = try? JSONDecoder().decode(APIResults.self, from: acquiredData) else {
                completionHandler(.failure(.cannotDecodeData))
                return
            }
            let queriedMovies = parsedData.results

            var queryResults: [QueryResult] = []
            for movie in queriedMovies {
                var result = QueryResult(withMovieStruct: movie, withTimeStamp: timeStamp)
                result.cover = self.cacheImage(withPosterPath: movie.poster_path)
                queryResults.append(result)
            }

            completionHandler(.success(queryResults))
        }

        dataTask.resume()
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