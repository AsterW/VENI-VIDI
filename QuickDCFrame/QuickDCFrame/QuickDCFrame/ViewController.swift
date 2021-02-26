//
//  ViewController.swift
//  QuickDCFrame
//
//  Created by 马晓雯 on 2/21/21.
//

import UIKit
import DCFrame

class ViewController: UIViewController {

    let dcTableView = DCContainerTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(dcTableView)
        
        let simpleListCM = SimpleListContainerModel()
        dcTableView.loadCM(simpleListCM)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //dcTableView.frame = view.bounds
        dcTableView.frame = view.bounds.inset(by: UIEdgeInsets(top: 40, left: 0, bottom: 20, right: 0))

    }

}

