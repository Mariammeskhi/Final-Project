//
//  FavoritesCollectionViewCell.swift
//  Final Project
//
//  Created by mariam meskhi on 16.02.25.
//

import UIKit
import CoreData
import Kingfisher

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

        func configure(with song: Song) {
            if let albumCover = song.albumCover, let url = URL(string: albumCover) {
                songImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            }
        }
    }
