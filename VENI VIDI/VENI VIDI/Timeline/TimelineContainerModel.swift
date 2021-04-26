//
//  TimelineContainerModek.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import DCFrame
import Foundation
import UIKit

class SimpleListContainerModel: VVContainerModel {
    var entries: [JournalEntry]?
    var currentTimeLabel: DateComponents?
    var type: String = "all"

    func getEntryData() {
        if let entries = dataService.fetchAllJournalEntries() {
            print(entries.count)
            self.entries = entries
        }
    }

    override func tableViewDataWillReload() {
        print("CM Reloading")
        currentTimeLabel = Calendar.current.dateComponents([.day, .year, .month], from: Date())

        removeAllSubmodels()

        addSubCell(TimelinePickerCell.self) { model in
            model.cellHeight = 50
        }

        getEntryData()

        if let dateComponents = currentTimeLabel {
            createTimeLabel(date: dateComponents)
        }

        if let entriesToDisplay = entries {
            for item in entriesToDisplay {
                print(type)
                print(item.journalType)
                if type != "all" {
                    if item.journalType.rawValue != type {
                        continue
                    }
                }

                let calanderDate = Calendar.current.dateComponents([.day, .year, .month], from: item.finishDate!)
                guard let timeLabel = currentTimeLabel else { return }
                if calanderDate.year != timeLabel.year || calanderDate.month != timeLabel.month {
                    currentTimeLabel = calanderDate
                    print("Calendar Date is \(calanderDate)")
                    createTimeLabel(date: calanderDate)
                }

                let model = TimelineCellModel()
                // swiftlint:disable:next identifier_name
                if let id = item.id {
                    model.entryId = id
                }
                model.title = item.entryTitle ?? "No Title"
                if let imageData = item.image {
                    print(imageData)
                    model.picture = UIImage(data: imageData)
                } else {
                    model.picture = UIImage(systemName: "star.fill")
                }
                model.rating = Double(item.rating)
//                if let tags = item.tags {
//                    model.tags = tags.allObjects as? [String] ?? []
//                }
                addSubmodel(model, separator: .bottom, height: 2)
            }
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    func createTimeLabel(date: DateComponents) {
        let timeModel = TimeLabelCellModel()
        switch date.month {
        case 1:
            timeModel.timeLabel = "\(date.year ?? 1970)  January"
        case 2:
            timeModel.timeLabel = "\(date.year ?? 1970)  February"
        case 3:
            timeModel.timeLabel = "\(date.year ?? 1970)  March"
        case 4:
            timeModel.timeLabel = "\(date.year ?? 1970)  April"
        case 5:
            timeModel.timeLabel = "\(date.year ?? 1970)  May"
        case 6:
            timeModel.timeLabel = "\(date.year ?? 1970)  June"
        case 7:
            timeModel.timeLabel = "\(date.year ?? 1970)  July"
        case 8:
            timeModel.timeLabel = "\(date.year ?? 1970)  August"
        case 9:
            timeModel.timeLabel = "\(date.year ?? 1970)  September"
        case 10:
            timeModel.timeLabel = "\(date.year ?? 1970)  Octuber"
        case 11:
            timeModel.timeLabel = "\(date.year ?? 1970)  November"
        case 12:
            timeModel.timeLabel = "\(date.year ?? 1970)  December"
        case .none:
            timeModel.timeLabel = ""
        case .some:
            timeModel.timeLabel = ""
        }
        addSubmodel(timeModel)
    }

    override func cmDidLoad() {
        super.cmDidLoad()

        subscribeEvent(TimelinePickerCell.timelineTypeChanged) { [weak self] (type: String) in
            self?.type = type
            self?.needReloadData()
        }

        print("load Timeline")
        containerTableView?.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)

        getEntryData()

        if let entriesToDisplay = entries {
            for item in entriesToDisplay {
                if type != "all" {
                    if item.journalType.rawValue != type {
                        continue
                    }
                }

                let model = TimelineCellModel()
                // swiftlint:disable:next identifier_name
                if let id = item.id {
                    model.entryId = id
                }
                model.title = item.entryTitle ?? "No Title"
                if let imageData = item.image {
                    print(imageData)
                    model.picture = UIImage(data: imageData)
                } else {
                    model.picture = UIImage(systemName: "star.fill")
                }
                model.rating = Double(item.rating)

                addSubmodel(model)
            }
        }
    }
}
