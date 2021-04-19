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
    var journalType: JournalEntryType {
        set { journalTypeText = newValue.rawValue }
        get { return JournalEntryType(rawValue: journalTypeText ?? "none") ?? .none }
    }
}
