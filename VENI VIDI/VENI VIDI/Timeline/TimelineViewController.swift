//
//  TimelineViewController.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 2/26/21.
//

import DCFrame
import Foundation
import SnapKit
import UIKit

class TimelineViewController: DCViewController {
    let simpleListCM = SimpleListContainerModel()

    override func viewWillAppear(_: Bool) {
        print("Reloading")

        simpleListCM.needReloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd))
        navigationController?.navigationBar.barTintColor = UIColor.systemBackground

        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil
        )
        title = "Timeline"

        EDC.subscribeEvent(TimelineCell.touch, target: self) { [weak self] (data: UUID) in
            print("pushing View Controller")
            guard let `self` = self else {
                return
            }
            let vc = DetailedEntryViewController()
            vc.entryId = data
//            vc.entryData.title = data.title
//            vc.entryData.comment = data.comment
//            vc.entryData.rate = data.rate
//            vc.entryData.url = data.url
//            vc.entryData.date=data.date
            self.navigationController?.pushViewController(vc, animated: true)
        }
        loadCM(simpleListCM)

        // get the entries from Core Data
//        if let entries=journalEntryService.fetchJournalEntries(){
//            let entryOne=entries[0]
//        }
    }

    @objc func onAdd() {
        let vc = UpdateEnrtyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
