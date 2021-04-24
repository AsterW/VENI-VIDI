//
//  GoogleBooksSearchAgent.swift
//  VENI VIDI
//
//  Created by 雲無心 on 3/29/21.
//

import Foundation

class GoogleBooksSearchAgent: DatabaseSpecificSearchAgent {
    var apiKey: String = ""
    var apiUrl: String = ""
    var agentType: QueryContentType = .book

    func query(withKeyword _: String,
               withTimeStamp _: TimeInterval,
               downloadCoverImage _: Bool,
               withCompletionHandler _: @escaping (Result<[QueryResult], QueryAgentError>) -> Void) {}
}
