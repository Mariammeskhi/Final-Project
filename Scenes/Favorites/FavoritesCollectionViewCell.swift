//
//  FavoritesCollectionViewCell.swift
//  Final Project
//
//  Created by mariam meskhi on 16.02.25.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var songImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
            songImage.layer.cornerRadius = 10
            songImage.clipsToBounds = true
        }
}
