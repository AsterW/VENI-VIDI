//
//  IGDBDataStructs.swift
//  VENI VIDI
//
//  Created by 雲無心 on 4/13/21.
//

// swiftlint:disable identifier_name

import Foundation

// MARK: - IGDBAccessTokenIssueRequest

struct IGDBAccessTokenIssueRequest: Encodable {
    init(withClientID clientID: String, withClientSecret clientSecret: String) {
        client_id = clientID
        client_secret = clientSecret
    }

    let client_id: String
    let client_secret: String
    let grant_type: String = "client_credentials"
}

// MARK: - IGDBAccessTokenResult

struct IGDBAccessTokenResult: Decodable {
    let access_token: String
    let expires_in: TimeInterval
    let token_type: String
}
