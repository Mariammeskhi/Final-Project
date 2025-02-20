//
//  UIImageView+Extension.swift
//  Final Project
//
//  Created by mariam meskhi on 20.02.25.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
