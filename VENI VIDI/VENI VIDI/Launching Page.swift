//
//  Launching Page.swift
//  VENI VIDI
//
//  Created by 马晓雯 on 4/9/21.
//

import DCFrame
import Foundation
import UIKit

class LaungchController: UIViewController {
    var entries: [JournalEntry] = []
    var entryLabels: [FloatLabel] = []

    private let dataService = DataService(coreDataStack: CoreDataStack())

    func fetchEntries() {
        if let fetchResult = dataService.fetchAllJournalEntries() {
            entries = fetchResult
        }
    }

//    func createLabelViews(entry: JournalEntry) {
//        let Y = Int.random(in: 0 ..< Int(view.bounds.height - 20))
//        print(Y)
//        let labelFrame = CGRect(x: Int(view.bounds.maxX), y: Y, width: 200, height: 20)
//        let labelView = FloatLabelView(frame: labelFrame)
//        print(view.frame)
//        labelView.label.text = entry.entryTitle
//        labelView.entryID = entry.id
//        entryLabels.append(labelView)
//    }

    func goToDetailedPage(id: UUID) {
        print(id)
        let vc = DetailedEntryViewController()
        vc.entryId = id

        navigationController?.pushViewController(vc, animated: true)
    }

    func gotoTimeline() {
        print("Timeline")
        let vc = TimelineViewController()
        navigationController?.pushViewController(vc, animated: false)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.location(in: view)

        for item in entryLabels {
            let labelFrame = item.layer.presentation()!.frame
            if labelFrame.contains(touchLocation) {
                goToDetailedPage(id: item.id!)
                return
            }
        }
        gotoTimeline()
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        entries = []
        entryLabels = []

        fetchEntries()
        print(entries.count)

        print("Launching Page")

        var index = 0
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
            let label = FloatLabel()
            label.text = self.entries[index].entryTitle
            if let entryId = self.entries[index].id {
                label.id = entryId
            }
            self.entryLabels.append(label)

//            let testL = FloatLabel()
//            testL.frame = CGRect(x: 190, y: 300, width: 100, height: 30)
//            self.view.addSubview(testL)
//            testL.text = "Test Click"
//            testL.isUserInteractionEnabled = true

            self.view.addSubview(label)
            let Y = Int.random(in: 50 ..< Int(self.view.bounds.height - 50))
            let labelFrame = CGRect(x: Int(self.view.bounds.maxX), y: Y, width: 200, height: 20)
            label.frame = labelFrame
//            label.isUserInteractionEnabled = true
//            let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.clickEntry(_:)))
//            label.addGestureRecognizer(guestureRecognizer)

            UIView.animate(withDuration: 10, delay: 0, options: UIView.AnimationOptions.allowUserInteraction, animations: { label.frame = CGRect(x: -200, y: Y, width: 200, height: 20) }, completion: nil)

            index += 1
            if index > self.entries.count - 1 {
                t.invalidate()
            }
        }
    }
}
