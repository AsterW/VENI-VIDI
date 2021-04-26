//
//  IGDBSearchAgent.swift
//  VENI VIDI
//
//  Created by 雲無心 on 3/29/21.
//

import Foundation
import UIKit

class IGDBSearchAgent: DatabaseSpecificSearchAgent {
    // MARK: - Properties

    internal var agentType: QueryContentType = .game

    private let clientID: String = "lvnmbqvnaakfxrprfxxt2pe6uosu0k"
    private let clientSecret: String = "gsxjvu9cpbr17jdy8b7weu9q8aae1v"
    private let gameSearchUrl: String = "https://api.igdb.com/v4/games"
    private let coverRequestUrl: String = "https://api.igdb.com/v4/covers"

    private var accessToken: String { updateAccessToken(); return "Bearer \(privateToken)" }
    private var privateToken: String = "" // the privately held access token without "Bearer" prefix
    private var accessTokenExpirationDate = Date()
    private let accessTokenRequestUrl: String = "https://id.twitch.tv/oauth2/token"
    private let accessTokenRevokeUrl: String = "https://id.twitch.tv/oauth2/revoke"

    // MARK: - Destructor

    deinit {
        revokeAccessToken()
    }

    // MARK: - DatabaseSpecificSearchAgent Query Function

    func query(withKeyword keyword: String,
               withTimeStamp timeStamp: TimeInterval,
               withCompletionHandler completionHandler: @escaping (Result<[QueryResult], QueryAgentError>) -> Void) {
        guard let targetUrl = URL(string: gameSearchUrl) else { fatalError() }
        var urlRequest = URLRequest(url: targetUrl)

        urlRequest.httpMethod = "POST"
        urlRequest.addValue("text/plain", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
        urlRequest.addValue(clientID, forHTTPHeaderField: "Client-iD")
        urlRequest.httpBody = Data("fields id,name,cover; search \"\(keyword)\";".utf8)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [self] data, _, _ in

            guard let acquiredData = data else {
                completionHandler(.failure(.noData))
                return
            }
            guard let parsedData = try? JSONDecoder().decode([IGDBDataStruct].self, from: acquiredData) else {
                completionHandler(.failure(.cannotDecodeData))
                return
            }

            let queriedGames = parsedData
            var queryResults: [QueryResult] = []

            for game in queriedGames {
                var result = QueryResult(withIGDBStruct: game, withTimeStamp: timeStamp)
                let url = retriveCoverImageUrl(withItemID: game.cover)
                result.coverUrl = url
                queryResults.append(result)
            }

            completionHandler(.success(queryResults))
        }
        dataTask.resume()
    }

    // MARK: - Helper Functions for Access Token

    func updateAccessToken() {
        if accessTokenExpirationDate > Date() {
            return
        }

        revokeAccessToken()
        let accessTokenIssueRequest = IGDBAccessTokenIssueRequest(withClientID: clientID,
                                                                  withClientSecret: clientSecret)
        guard let targetUrl = URL(string: accessTokenRequestUrl) else { fatalError() }
        var urlRequest = URLRequest(url: targetUrl)

        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(accessTokenIssueRequest)

        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [self] data, _, _ in
            guard let receivedData = data else { fatalError() }
            guard let parsedData = try? JSONDecoder().decode(IGDBAccessTokenResult.self,
                                                             from: receivedData) else { fatalError() }
            privateToken = parsedData.access_token
            accessTokenExpirationDate = Date(timeIntervalSinceNow: parsedData.expires_in)
            dispatchGroup.leave()
        }

        dataTask.resume()

        dispatchGroup.wait()
    }

    func revokeAccessToken() {
        var urlComponents = URLComponents(string: accessTokenRevokeUrl)
        urlComponents?.queryItems = [URLQueryItem(name: "client_id", value: clientID),
                                     URLQueryItem(name: "token", value: accessToken)]
        guard let requestURL = urlComponents?.url?.absoluteURL else { fatalError() }

        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { _, _, _ in }

        dataTask.resume()
    }

    // MARK: - Helper Function for Retrive Cover Url

    func retriveCoverImageUrl(withItemID itemID: Int?) -> String? {
        // swiftlint:disable:next identifier_name
        guard let id = itemID else {
            print("retriveCoverImageUrl returns due to nil input")
            return nil
        }
        guard let requestUrl = URL(string: coverRequestUrl) else { fatalError() }
        var urlRequest = URLRequest(url: requestUrl)

        urlRequest.httpMethod = "POST"
        urlRequest.addValue("text/plain", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
        urlRequest.addValue(clientID, forHTTPHeaderField: "Client-iD")
        urlRequest.httpBody = Data("fields url; where game = \(id);".utf8)

        var urlToReturn: String?

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
            guard let acquiredData = data else { return }
            guard let parsedData =
                try? JSONDecoder().decode(IGDBCoverRequestDataStruct.self, from: acquiredData) else { return }
            urlToReturn = parsedData.url
        }

        dataTask.resume()
        return urlToReturn
    }
}
