//
//  IGDBSearchAgent.swift
//  VENI VIDI
//
//  Created by 雲無心 on 3/29/21.
//

import Foundation

class IGDBSearchAgent: DatabaseSpecificSearchAgent {
    // MARK: - Properties

    internal var agentType: QueryContentType = .game

    private let clientID: String = "lvnmbqvnaakfxrprfxxt2pe6uosu0k"
    private let clientSecret: String = "gsxjvu9cpbr17jdy8b7weu9q8aae1v"
    private let requestBaseUrl: String = "https://api.twitch.tv/kraken/search/games"

    private var accessToken: String = ""
    private var accessTokenForRequest: String { return "Bearer \(accessToken)" }
    private var accessTokenExpirationDate = Date()
    private let accessTokenRequestUrl: String = "https://id.twitch.tv/oauth2/token"
    private let accessTokenRevokeUrl: String = "https://id.twitch.tv/oauth2/revoke"

    // MARK: - Destructor

    deinit {
        revokeAccessToken()
    }

    // MARK: - DatabaseSpecificSearchAgent Query Function

    func query(withKeyword _: String, withTimeStamp _: TimeInterval, downloadCoverImage _: Bool, withCompletionHandler _: @escaping (Result<[QueryResult], QueryAgentError>) -> Void) {}

    // MARK: - Helper Functions for access token

    func getAccessToken() -> String {
        if accessTokenExpirationDate > Date() {
            return accessToken
        }

        revokeAccessToken()
        let accessTokenIssueRequest = IGDBAccessTokenIssueRequest(withClientID: clientID, withClientSecret: clientSecret)
        guard let targetUrl = URL(string: accessTokenRequestUrl) else { fatalError() }
        var urlRequest = URLRequest(url: targetUrl)

        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(accessTokenIssueRequest)

        let group = DispatchGroup()

        group.enter()
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [self] data, _, _ in
            guard let receivedData = data else { fatalError() }
            guard let parsedData = try? JSONDecoder().decode(IGDBAccessTokenResult.self, from: receivedData) else { fatalError() }
            accessToken = parsedData.access_token
            accessTokenExpirationDate = Date(timeIntervalSinceNow: parsedData.expires_in)
            group.leave()
        }

        dataTask.resume()

        group.wait()
        return accessToken
    }

    func revokeAccessToken() {
        var urlComponents = URLComponents(string: accessTokenRevokeUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "token", value: accessToken),
        ]
        guard let requestURL = urlComponents?.url?.absoluteURL else { fatalError() }

        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { _, _, _ in }

        dataTask.resume()
    }
}
