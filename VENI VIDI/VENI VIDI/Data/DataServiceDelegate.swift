//
//  DataServiceDelegate.swift
//  VENI VIDI
//
//  Created by 雲無心 on 3/30/21.
//

import Foundation

protocol DataServiceDelegate {
    func fetchAllJournalEntriesResultDidChange(_ result: [JournalEntry])
}
