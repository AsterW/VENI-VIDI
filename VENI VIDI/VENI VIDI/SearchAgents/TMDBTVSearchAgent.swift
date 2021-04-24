//
//  TMDBTVSearchAgent.swift
//  VENI VIDI
//
//  Created by 雲無心 on 4/13/21.
//

import Foundation
import UIKit

class TMDBTVSearchAgent: DatabaseSpecificSearchAgent {
    // MARK: - Properties

    internal let agentType: QueryContentType = .tvShow

    private let apiUrl: String = "https://api.themoviedb.org/3/search/tv"
    private let apiKey: String = "29748b6586282540605ffb47f2378ad4"

    private let imageUrl500 = "https://image.tmdb.org/t/p/w500"
    private let imageUrlOriginal = "https://image.tmdb.org/t/p/original"

    // MARK: - DatabaseSpecificSearchAgent Query Function

    func query(withKeyword keyword: String,
               withTimeStamp timeStamp: TimeInterval,
               downloadCoverImage: Bool = false,
               withCompletionHandler completionHandler: @escaping (Result<[QueryResult], QueryAgentError>) -> Void) {
        var urlComponents = URLComponents(string: apiUrl)
        urlComponents?.queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                                     URLQueryItem(name: "query", value: keyword)]

        guard let requestURL = urlComponents?.url?.absoluteURL else { completionHandler(.failure(.urlError))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: requestURL) { data, _, _ in
            guard let acquiredData = data else {
                completionHandler(.failure(.noData))
                return
            }
            guard let parsedData = try? JSONDecoder().decode(TMDBTVQueryResults.self, from: acquiredData) else {
                completionHandler(.failure(.cannotDecodeData))
                return
            }
            let queriedTVShows = parsedData.results

            var queryResults: [QueryResult] = []
            for tvShow in queriedTVShows {
                var result = QueryResult(withTVStruct: tvShow, withTimeStamp: timeStamp)
                if downloadCoverImage {
                    result.cover = self.cacheImage(withPosterPath: tvShow.poster_path)
                } else {
                    result.coverUrl = tvShow.poster_path != nil ? self.imageUrl500 + tvShow.poster_path! : ""
                }
                queryResults.append(result)
            }

            completionHandler(.success(queryResults))
        }

        dataTask.resume()
    }

    // MARK: - Helper Function

    func cacheImage(withPosterPath posterPath: String?) -> UIImage? {
        if let path = posterPath {
            let imageUrl = URL(string: imageUrl500 + path)
            let data = try? Data(contentsOf: imageUrl!)
            return UIImage(data: data!)
        } else {
            return nil
        }
    }

    func retriveImageUrl(withPosterPath posterPath: String?) -> URL? {
        if let path = posterPath {
            return URL(string: imageUrl500 + path)
        } else {
            return nil
        }
    }
}
