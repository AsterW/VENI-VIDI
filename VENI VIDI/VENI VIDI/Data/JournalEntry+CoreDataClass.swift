//
//  JournalEntry+CoreDataClass.swift
//
//
//  Created by 雲無心 on 4/19/21.
//
//

import CoreData
import Foundation

@objc(JournalEntry)
public class JournalEntry: NSManagedObject {
    private var journalType: String = "none"
    var type: JournalEntryType {
        set { journalType = newValue.rawValue }
        get { return JournalEntryType(rawValue: journalType) ?? .none }
    }
}
