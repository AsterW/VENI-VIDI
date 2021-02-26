//
//  TimelineTableViewController.swift
//  QuickDCFrame
//
//  Created by 马晓雯 on 2/21/21.
//

import Foundation
import UIKit
import DCFrame

class TimelineTableViewController: UIViewController {
    public let dcTableView = DCContainerTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.addSubview(dcTableView)

        loadData()
    }

      private func loadData() {
          let listCM = DCContainerModel()
          for num in 1..<100 {
              let model = TimelineCellModel()
              model.title = "\(num)"
              listCM.addSubmodel(model)
        }
          dcTableView.loadCM(listCM)
    }
  
      override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        dcTableView.frame = view.frame
        dcTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        dcTableView.contentOffset = CGPoint(x: 0, y: 0)
    }
}
