//
//  ViewController.swift
//  VENI VIDI
//
//  Created by 雲無心 on 2/12/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = TimelineViewController.init()
        self.navigationController?.setViewControllers([vc], animated: true)
    }


}

