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
        if let id = entryId {
            if let entry = dataService.fetchJournalEntryWithUUID(id) {
                detailCM.entryTitle = entry.worksTitle
                detailCM.comment = entry.entryContent
                detailCM.date = entry.finishDate
                if let imageData = entry.image {
                    detailCM.poster = UIImage(data: imageData)
                }
                detailCM.stars = Double(entry.rating)
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
                if (navigationController?.viewControllers[count - 2] as? LaungchController) != nil{
                    navigationItem.hidesBackButton = true
                    
                    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Timeline", style: .plain, target: self, action: #selector(backToTimeline))
                }
                else{
                    
                }
            }
        }


        print("Entry Id is \(String(describing: entryId))")


        let dataService = DataService(coreDataStack: CoreDataStack())
        if let id = entryId {
            if let entry = dataService.fetchJournalEntryWithUUID(id) {
                detailCM.entryTitle = entry.worksTitle
                detailCM.comment = entry.entryContent
                if let imageData = entry.image {
                    detailCM.poster = UIImage(data: imageData)
                }
                detailCM.stars = Double(entry.rating)
            }
        }

        loadCM(detailCM)

        // nav bar item to edit
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(onEdit))
    }

    @objc func onEdit() {
        let vc = UpdateEnrtyViewController()
        if let id = entryId {
            vc.entryId = id
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func backToTimeline() {
        let vc = TimelineViewController()
        navigationController?.pushViewController(vc, animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
