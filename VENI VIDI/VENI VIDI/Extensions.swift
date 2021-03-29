//
//  Extensions.swift
//  VENI VIDI
//
//  Created by MonAster on 2021/3/29.
//

import Foundation
import UIKit

extension UIImageView {
    func load(withURL urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        
                    }
                }
            }
        }
    }
}
