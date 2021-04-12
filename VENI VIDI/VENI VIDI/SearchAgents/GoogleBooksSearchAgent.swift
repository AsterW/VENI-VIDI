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
    var delegate: DatabaseSpecificSearchAgentDelegate?

    func query(withKeyword _: String, withTimeStamp _: Date) {}
}
