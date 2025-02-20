//
//  SongsCollectionViewCell.swift
//  Final Project
//
//  Created by mariam meskhi on 15.02.25.
//

import UIKit

class SongsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var songImage: UIImageView!
    
    
    @IBOutlet weak var songName: UILabel!
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
        }
        
        func configure(with song: Song) {
            songName.text = song.name
            if let albumCover = song.albumCover, let imageUrl = URL(string: albumCover) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.songImage.image = image
                        }
                    }
                }
            } else {
                songImage.image = UIImage(named: "placeholder") 
            }
        }
    }
