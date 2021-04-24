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

        // let vc = TimelineViewController()
        let vc = LaungchController() // swiftlint:disable:this identifier_name
        navigationController?.setViewControllers([vc], animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemYellow
    }
}
