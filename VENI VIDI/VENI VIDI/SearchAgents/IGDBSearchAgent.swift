//
//  IGDBSearchAgent.swift
//  VENI VIDI
//
//  Created by 雲無心 on 3/29/21.
//

import Foundation

class IGDBSearchAgent: DatabaseSpecificSearchAgent {
    var apiKey: String = ""
    var apiUrl: String = ""
    var agentType: QueryContentType = .game

    func query(withKeyword _: String, withTimeStamp _: TimeInterval, withCompletionHandler _: @escaping (Result<[QueryResult], QueryAgentError>) -> Void) {}
}
