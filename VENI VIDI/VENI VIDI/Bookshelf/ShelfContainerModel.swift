//
//  ShelfContainerModel.swift
//  VENI VIDI
//
//  Created by MonAster on 2021/4/26.
//

import DCFrame
import SnapKit
import UIKit

class ShelfContainerModel: VVContainerModel {
    var entries: [JournalEntry]?
    var bookEntries: [JournalEntry] = []
    var movieEntries: [JournalEntry] = []
    var tvShowEntries: [JournalEntry] = []

    func getEntryData() {
        if let entries = dataService.fetchAllJournalEntries() {
            print(entries.count)
            self.entries = entries
        }
    }

    override func tableViewDataWillReload() {

        removeAllSubmodels()
        bookEntries = []
        movieEntries = []
        tvShowEntries = []

        getEntryData()

        if let entriesToDisplay = entries {
            for item in entriesToDisplay {
                switch item.journalType.rawValue {
                case "book":
                    bookEntries.append(item)
                case "movie":
                    movieEntries.append(item)
                case "tvShow":
                    tvShowEntries.append(item)
                default:
                    break
                }
            }
            let bookCollection = ShelfCellModel()
            bookCollection.set(withType: .book, withEntries: bookEntries)
            let movieCollection = ShelfCellModel()
            movieCollection.set(withType: .movie, withEntries: movieEntries)
            let tvShowCollection = ShelfCellModel()
            tvShowCollection.set(withType: .tvShow, withEntries: tvShowEntries)
            addSubmodels([bookCollection, movieCollection, tvShowCollection])
        }
    }

    override func cmDidLoad() {
        super.cmDidLoad()

        getEntryData()

        containerTableView?.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 100, right: 0)

        if let entriesToDisplay = entries {
            for item in entriesToDisplay {
                switch item.journalType.rawValue {
                case "book":
                    bookEntries.append(item)
                case "movie":
                    movieEntries.append(item)
                case "tvShow":
                    tvShowEntries.append(item)
                default:
                    break
                }
            }
            let bookCollection = ShelfCellModel()
            bookCollection.set(withType: .book, withEntries: bookEntries)
            let movieCollection = ShelfCellModel()
            movieCollection.set(withType: .movie, withEntries: movieEntries)
            let tvShowCollection = ShelfCellModel()
            tvShowCollection.set(withType: .tvShow, withEntries: tvShowEntries)
            addSubmodels([bookCollection, movieCollection, tvShowCollection])
        }
    }
}
