//
//  SearchAgentProtocols.swift
//  VENI VIDI
//
//  Created by 雲無心 on 4/12/21.
//

import Foundation
import UIKit

protocol GeneralSearchAgentDeletage {
    func receivedQueryResult(_ result: [QueryResult], for queryContentType: QueryContentType)
}

protocol DatabaseSpecificSearchAgent {
    var apiKey: String { get }
    var apiUrl: String { get }
    var agentType: QueryContentType { get }
    var delegate: DatabaseSpecificSearchAgentDelegate? { get }

    func query(withKeyword keyword: String, withTimeStamp timeStamp: Date)
}

protocol DatabaseSpecificSearchAgentDelegate {
    func receivedQueryResult(_ result: [QueryResult], for queryContentType: QueryContentType, withTimeStamp timeStamp: Date)
}
