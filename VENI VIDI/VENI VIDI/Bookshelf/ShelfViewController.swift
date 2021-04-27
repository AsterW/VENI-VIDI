//
//  ShelfViewController.swift
//  VENI VIDI
//
//  Created by MonAster on 2021/4/25.
//

import DCFrame
import SnapKit
import UIKit

class ShelfViewController: DCViewController {
    let shelfCM = ShelfContainerModel()

    override func viewWillAppear(_: Bool) {
        shelfCM.needReloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Shelf"
        loadCM(shelfCM)
    }
}
