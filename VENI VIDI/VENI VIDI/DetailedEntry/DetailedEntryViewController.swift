//
//  DetailedEntryViewController.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import DCFrame
import Foundation
import UIKit

class DetailedEntryViewController: DCViewController {
    var entryData = EntryData()
    var entryId: UUID?
    let detailCM = DetailedEntryContainerModel()

    override func viewWillAppear(_: Bool) {
        let dataService = DataService(coreDataStack: CoreDataStack())
        // swiftlint:disable:next identifier_name
        if let id = entryId {
            if let entry = dataService.fetchJournalEntryWithUUID(id) {
                detailCM.entryTitle = entry.worksTitle
                detailCM.comment = entry.entryContent
                detailCM.date = entry.finishDate
                detailCM.quote = entry.quote
                if let imageData = entry.image {
                    detailCM.poster = UIImage(data: imageData)
                }
                detailCM.stars = Double(entry.rating)
                detailCM.favorite = entry.favorite
            }
        }

        detailCM.needReloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemBackground

        // check the previous controller
        if let count = navigationController?.viewControllers.count {
            if count >= 2 {
                if (navigationController?.viewControllers[count - 2] as? LaungchController) != nil {
                    navigationItem.hidesBackButton = true

                    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Timeline", style: .plain, target: self, action: #selector(backToTimeline))
                } else {}
            }
        }

        print("Entry Id is \(String(describing: entryId))")

        let dataService = DataService(coreDataStack: CoreDataStack())
        // swiftlint:disable:next identifier_name
        if let id = entryId {
            if let entry = dataService.fetchJournalEntryWithUUID(id) {
//                title = entry.worksTitle
                detailCM.entryTitle = entry.worksTitle
                detailCM.comment = entry.entryContent
                detailCM.quote = entry.quote
                if let imageData = entry.image {
                    detailCM.poster = UIImage(data: imageData)
                }
                detailCM.stars = Double(entry.rating)
                detailCM.favorite = entry.favorite
            }
        }

        loadCM(detailCM)

        // nav bar item to edit
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(onEdit))
    }

    @objc func onEdit() {
        let updateEntryVC = UpdateEnrtyViewController()
        // swiftlint:disable:next identifier_name
        if let id = entryId {
            updateEntryVC.entryId = id
        }
        navigationController?.pushViewController(updateEntryVC, animated: true)
    }

    @objc func backToTimeline() {
        let timelineVC = TimelineViewController()
        navigationController?.pushViewController(timelineVC, animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
